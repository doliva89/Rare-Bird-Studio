/**
 * Precomputed Atmospheric Scattering
 * Copyright (c) 2008 INRIA
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holders nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * Author: Eric Bruneton
 */


Shader "Azure[Sky]/Precomputed Fog Scattering"
{
	Properties 
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader 
	{
	    Pass 
	    {
	    	// No culling or depth
		    Cull Off ZWrite Off ZTest Always
	    
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			
			uniform sampler2D         _MainTex;
			uniform float4            _MainTex_TexelSize;
			uniform sampler2D_float   _CameraDepthTexture;
			uniform float4x4          _FrustumCorners, _Azure_MoonMatrix;
			uniform float             _Azure_GammaCorrection, _Azure_PrecomputedMieDepth, _Azure_PrecomputedFogDensity, _PrecomputedSkyElevation, _Azure_Pi, _Azure_PrecomputedSunIntensity, _Azure_PrecomputedMoonIntensity,
			                          _Azure_PrecomputedExposure, _Azure_PrecomputedDeepDarkness, _Azure_MoonSkyBright, _Azure_MoonSkyBrightRange, _Azure_MoonDiskBright, _Azure_MoonDiskBrightRange, _Azure_LightSpeed,
									  _Azure_PrecomputedFixBlackScreenColor;
			uniform float3            _Azure_SunDirection, _Azure_MoonDirection, _Azure_PrecomputedNightColor;

			uniform sampler3D _Precomputed_Inscatter;
			uniform sampler2D _Precomputed_Transmittance;

			uniform float _Azure_PrecomputedRt, _Azure_PrecomputedRg;

			static const float  _Azure_PrecomputedMieG = 0.75;
			static const float3 _Azure_PrecomputedBetaR = float3(0.0058, 0.0135, 0.0331);
			static const float  _Azure_Precomputed_RES_MU = 128.0;
			static const float  _Azure_Precomputed_RES_R = 32.0;
			static const float  _Azure_Precomputed_RES_MU_S = 32.0;
			static const float  _Azure_Precomputed_RES_NU = 8.0;

			//-------------------------------------------------------------------------------------------------------
			float3 hdr(float3 L)
			{
			//    L = L * 0.4;
			//    L.r = L.r < 1.413 ? pow(L.r * 0.38317, 1.0 / 2.2) : 1.0 - exp(-L.r);
			//    L.g = L.g < 1.413 ? pow(L.g * 0.38317, 1.0 / 2.2) : 1.0 - exp(-L.g);
			//    L.b = L.b < 1.413 ? pow(L.b * 0.38317, 1.0 / 2.2) : 1.0 - exp(-L.b);
			    L = 1.0 - exp( -_Azure_PrecomputedExposure * L);
			    return L;
			}

			float4 Texture4D(sampler3D table, float r, float mu, float muS, float nu)
			{
			   	float H = sqrt(_Azure_PrecomputedRt * _Azure_PrecomputedRt - _Azure_PrecomputedRg * _Azure_PrecomputedRg);
			   	float rho = sqrt(r * r - _Azure_PrecomputedRg * _Azure_PrecomputedRg);
			   	float rmu = r * mu;
			    float delta = rmu * rmu - r * r + _Azure_PrecomputedRg * _Azure_PrecomputedRg;
			    float4 cst = rmu < 0.0 && delta > 0.0 ? float4(1.0, 0.0, 0.0, 0.5 - 0.5 / _Azure_Precomputed_RES_MU) : float4(-1.0, H * H, H, 0.5 + 0.5 / _Azure_Precomputed_RES_MU);
			    float uR = 0.5 / _Azure_Precomputed_RES_R + rho / H * (1.0 - 1.0 / _Azure_Precomputed_RES_R);
			    float uMu = cst.w + (rmu * cst.x + sqrt(delta + cst.y)) / (rho + cst.z) * (0.5 - 1.0 / float(_Azure_Precomputed_RES_MU));
			    float uMuS = 0.5 / _Azure_Precomputed_RES_MU_S + (atan(max(muS, -0.1975) * tan(1.26 * 1.1)) / 1.1 + (1.0 - 0.26)) * 0.5 * (1.0 - 1.0 / _Azure_Precomputed_RES_MU_S);
			    float _lerp = (nu + 1.0) / 2.0 * (_Azure_Precomputed_RES_NU - 1.0);
			    float uNu = floor(_lerp);
			    _lerp = _lerp - uNu;
			    //return tex3Dlod(table, float4((uNu + uMuS) / _Azure_Precomputed_RES_NU, uMu, _elevation, 0)) * (1.0 - _lerp) + tex3Dlod(table, float4((uNu + uMuS + 1.0) / _Azure_Precomputed_RES_NU, uMu, _elevation, 0)) * _lerp;
			    return tex3D(table, float3((uNu + uMuS) / _Azure_Precomputed_RES_NU, uMu, _PrecomputedSkyElevation)) * (1.0 - _lerp) + tex3D(table, float3((uNu + uMuS + 1.0) / _Azure_Precomputed_RES_NU, uMu, _PrecomputedSkyElevation)) * _lerp;
			}

			float3 GetMie(float4 rayMie)
			{	
			   	return rayMie.rgb * rayMie.w / max(rayMie.r, 1e-4) * (_Azure_PrecomputedBetaR.r / _Azure_PrecomputedBetaR);
			}

			float PhaseFunctionR(float mu)
			{
			    return (3.0 / (16.0 * _Azure_Pi)) * (1.0 + mu * mu);
			}

			float PhaseFunctionM(float mu)
			{
			   	 return 1.5 * 1.0 / (4.0 * _Azure_Pi) * (1.0 - _Azure_PrecomputedMieG*_Azure_PrecomputedMieG) * pow(1.0 + (_Azure_PrecomputedMieG*_Azure_PrecomputedMieG) - 2.0*_Azure_PrecomputedMieG*mu, -3.0/2.0) * (1.0 + mu * mu) / (2.0 + _Azure_PrecomputedMieG*_Azure_PrecomputedMieG);
			}

			float3 Transmittance(float r, float mu) 
			{
			   	float uR, uMu;
			    uR = sqrt((r - _Azure_PrecomputedRg) / (_Azure_PrecomputedRt - _Azure_PrecomputedRg));
			    uMu = atan((mu + 0.15) / (1.0 + 0.15) * tan(1.5)) / 1.5;
			    return tex2D(_Precomputed_Transmittance, float2(uMu, uR)).rgb;
			}

			float3 InScattering(float3 camera, float3 _point, float3 lightdir, float lightIntensity, out float3 extinction, float shaftWidth, float depth, float3 skyColor) 
			{
			    float3 result = float3(0,0,0);
			    extinction = float3(1,1,1);
			        
			    float3 viewdir = _point - camera;
			    float d = length(viewdir);
			    viewdir = viewdir / d;
			    float r = length(camera);
			        
			    if (r < 0.9 * _Azure_PrecomputedRg)
			    {
			        camera.y += _Azure_PrecomputedRg;
			        _point.y += _Azure_PrecomputedRg;
			        r = length(camera);
			    }
			    float rMu = dot(camera, viewdir);
			    float mu = rMu / r;
			    float r0 = r;
			    float mu0 = mu;
			    _point -= viewdir * clamp(shaftWidth, 0.0, d);

			    float deltaSq = sqrt(rMu * rMu - r * r + _Azure_PrecomputedRt*_Azure_PrecomputedRt);
			    float din = max(-rMu - deltaSq, 0.0);
			    
			    if (din > 0.0 && din < d)
			    {
			        camera += din * viewdir;
			        rMu += din;
			        mu = rMu / _Azure_PrecomputedRt;
			        r = _Azure_PrecomputedRt;
			        d -= din;
			    }

			    if (r <= _Azure_PrecomputedRt)
			    {
			        float nu = dot(viewdir, lightdir);
			        float muS = dot(camera, lightdir) / r;

			        float4 inScatter;

			        if (r < _Azure_PrecomputedRg + 600.0) 
			        {
			            // avoids imprecision problems in aerial perspective near ground
			            float f = (_Azure_PrecomputedRg + 600.0) / r;
			            r = r * f;
			            rMu = rMu * f;
			            _point = _point * f;
			        }

			        float r1 = length(_point);
			        float rMu1 = dot(_point, viewdir);
			        float mu1 = rMu1 / r1;
			        float muS1 = dot(_point, lightdir) / r1;

			        if (mu > 0.0) 
			            extinction = min(Transmittance(r, mu) / Transmittance(r1, mu1), 1.0);
			        else 
			            extinction = min(Transmittance(r1, -mu1) / Transmittance(r, -mu), 1.0);

			        const float EPS = 0.004;
			        float lim = -sqrt(1.0 - (_Azure_PrecomputedRg / r) * (_Azure_PrecomputedRg / r));
			        
			        if (abs(mu - lim) < EPS) 
			        {
			            float a = ((mu - lim) + EPS) / (2.0 * EPS);

			            mu = lim - EPS;
			            r1 = sqrt(r * r + d * d + 2.0 * r * d * mu);
			            mu1 = (r * mu + d) / r1;
			            
			            float4 inScatter0 = Texture4D(_Precomputed_Inscatter, r, mu, muS, nu);
			            float4 inScatter1 = Texture4D(_Precomputed_Inscatter, r1, mu1, muS1, nu);
			            float4 inScatterA = max(inScatter0 - inScatter1 * extinction.rgbr, 0.0);

			            mu = lim + EPS;
			            r1 = sqrt(r * r + d * d + 2.0 * r * d * mu);
			            mu1 = (r * mu + d) / r1;
			            
			            inScatter0 = Texture4D(_Precomputed_Inscatter, r, mu, muS, nu);
			            inScatter1 = Texture4D(_Precomputed_Inscatter, r1, mu1, muS1, nu);
			            float4 inScatterB = max(inScatter0 - inScatter1 * extinction.rgbr, 0.0);

			            inScatter = lerp(inScatterA, inScatterB, a);
			        } 
			        else 
			        {
			            float4 inScatter0 = Texture4D(_Precomputed_Inscatter, r, mu, muS, nu);
			            float4 inScatter1 = Texture4D(_Precomputed_Inscatter, r1, mu1, muS1, nu);
			            inScatter = max(inScatter0 - inScatter1 * extinction.rgbr, 0.0);
			        }

			        // avoids imprecision problems in Mie scattering when sun is below horizon
			        inScatter.w *= smoothstep(0.00, 0.02, muS);

			        float3 inScatterM = GetMie(inScatter) * saturate(depth);
			        float phase = PhaseFunctionR(nu);
			        float phaseM = PhaseFunctionM(nu);
			        result = inScatter.rgb * phase + inScatterM * phaseM;
			    } 

			    return result * skyColor * lightIntensity;

			}

			//-------------------------------------------------------------------------------------------------------
			struct appdata
			{
				float4 vertex   : POSITION;
				float4 texcoord : TEXCOORD0;
			};

			struct v2f 
			{
				float4 Position        : SV_POSITION;
    			float2 uv 	           : TEXCOORD0;
				float4 interpolatedRay : TEXCOORD1;
				float2 uv_depth        : TEXCOORD2;
			};
			
			v2f vert( appdata v )
			{
				v2f o;
    			UNITY_INITIALIZE_OUTPUT(v2f, o);

				//int index = v.vertex.z;
				v.vertex.z = 0.1;
				o.Position = UnityObjectToClipPos(v.vertex);
				o.uv       = v.texcoord.xy;
				o.uv_depth = v.texcoord.xy;
				#if UNITY_UV_STARTS_AT_TOP
				if (_MainTex_TexelSize.y < 0)
					o.uv.y = 1-o.uv.y;
				#endif

				//Based on Unity5.6 GlobalFog.
				int index = v.texcoord.x + (2 * o.uv.y);
				o.interpolatedRay   = _FrustumCorners[index];
				o.interpolatedRay.w = index;

				return o;
			}
			
			half4 frag(v2f IN) : SV_Target 
			{
				float4 sceneColor = tex2D(_MainTex, UnityStereoTransformScreenSpaceTex(IN.uv));
				float4 skyColor   = sceneColor;
				
				float dpth = Linear01Depth(UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture,UnityStereoTransformScreenSpaceTex(IN.uv_depth))));
				float3 worldPos = (dpth * IN.interpolatedRay.xyz);
				float3 viewDir  = normalize(dpth * IN.interpolatedRay.xyz);
				//return float4(dpth,dpth,dpth,1);

				if(dpth == 1.0) return skyColor;

				float3 dir = normalize(worldPos-_WorldSpaceCameraPos);
				float r    = length(float3(0, _Azure_LightSpeed, 0));

				//Sun Scattering.
			    //-------------------------------------------------------------------------------------------------------
				float3 extinction = float3(0,0,0);
				float3 inscatter = InScattering(float3(1, 1, 1), worldPos * float3(_Azure_PrecomputedFogDensity, 0, _Azure_PrecomputedFogDensity), _Azure_SunDirection, _Azure_PrecomputedSunIntensity, extinction, 1.0, dpth * _Azure_PrecomputedMieDepth, float3(1.0, 1.0, 1.0));
				float3 nightSky = (1.0 - extinction) * _Azure_PrecomputedDeepDarkness;

				//Moon Scattering.
			    //-------------------------------------------------------------------------------------------------------
			    float3 moonExtinction;
				float3 moonInscatter = InScattering(float3(1, 1, 1), worldPos * float3(_Azure_PrecomputedFogDensity, 0, _Azure_PrecomputedFogDensity), _Azure_MoonDirection, _Azure_PrecomputedMoonIntensity, moonExtinction, 1.0, dpth * _Azure_PrecomputedMieDepth, _Azure_PrecomputedNightColor);
				nightSky += moonInscatter;

				//Moon Bright.
				//-------------------------------------------------------------------------------------------------------
				float  moonRise     = saturate(dot(float3(0, 500,0), _Azure_MoonDirection) / r);
			    float  moonPosition = 1.0 + dot( viewDir, _Azure_MoonMatrix[2].xyz);
			    float3 moonBright   = 1.0 / (_Azure_MoonSkyBright  + moonPosition * _Azure_MoonSkyBrightRange)  * moonInscatter.rgb;
				       moonBright  += 1.0 / (_Azure_MoonDiskBright + moonPosition * _Azure_MoonDiskBrightRange) * moonInscatter.rgb;

				//Color Correction.
				#ifdef UNITY_COLORSPACE_GAMMA
				skyColor.rgb = skyColor.rgb * extinction + inscatter + nightSky;
				skyColor.rgb = hdr(skyColor.rgb);

				#else
				skyColor.rgb  = LinearToGammaSpace (skyColor.rgb);//Only screen.
				skyColor.rgb  = skyColor.rgb * extinction + inscatter + nightSky;
				skyColor.rgb += max(0.0, moonBright * moonRise);
				skyColor.rgb  = hdr(skyColor.rgb);
				skyColor.rgb  = GammaToLinearSpace (skyColor.rgb);//Whole Scene.
    			#endif
			    skyColor = pow(skyColor,_Azure_GammaCorrection);

				skyColor.rgb = lerp(sceneColor.rgb, skyColor.rgb, saturate(dpth * _Azure_PrecomputedFixBlackScreenColor));//Fix black screen color.
				return float4(skyColor.rgb, 1.0);
			}
			ENDCG
	    }
	}
}
