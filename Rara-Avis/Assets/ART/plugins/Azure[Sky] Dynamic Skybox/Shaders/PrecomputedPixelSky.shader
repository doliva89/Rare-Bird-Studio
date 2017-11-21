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


Shader "Azure[Sky]/Pixel/Precomputed Sky"
{
	SubShader 
	{
		Tags { "Queue"="Background" "RenderType"="Background" "PreviewType"="Skybox" "IgnoreProjector"="True" }
	    Cull [_Azure_CullMode] // Render side
		Fog{Mode Off}          // Don't use fog
    	ZWrite Off             // Don't draw to bepth buffer

    	Pass 
    	{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		    #pragma target 3.0
		    #include "UnityCG.cginc"

			uniform int      _Azure_PrecomputedSkyGround;
			uniform float    _Azure_GammaCorrection, _Azure_SunDiskSize, _Azure_SunDiskPropagation, _PrecomputedSkyElevation, _Azure_Pi, _Azure_PrecomputedSunIntensity, _Azure_PrecomputedMoonIntensity,
			                 _Azure_PrecomputedExposure, _Azure_MilkyWayIntensity, _Azure_StarfieldIntensity, _Azure_PrecomputedDeepDarkness, _Azure_MoonSkyBright, _Azure_MoonSkyBrightRange, _Azure_MoonDiskBright,
			                 _Azure_MoonDiskBrightRange, _Azure_MoonDiskSize, _Azure_LightSpeed;
			uniform float3   _Azure_SunDirection, _Azure_MoonDirection, _Azure_StarfieldColorBalance, _Azure_PrecomputedNightColor, _Azure_MoonDiskColor;
			uniform float4x4 _Azure_SunMatrix, _Azure_WtLSunMatrix, _Azure_MoonMatrix, _Azure_StarfieldMatrix, _Azure_NoiseMatrix;

			uniform samplerCUBE _Azure_StarfieldTexture, _AzureStarNoiseTexture;

			uniform sampler3D _Precomputed_Inscatter;
			uniform sampler2D _Precomputed_Transmittance, _Azure_PrecomputedSunGlare, _Azure_MoonTexture;

			uniform float _Azure_PrecomputedRt, _Azure_PrecomputedRg;

			static const float _Azure_PrecomputedMieG = 0.75;
			static const float3 _Azure_PrecomputedBetaR = float3(0.0058, 0.0135, 0.0331);
			static const float3 _Azure_PrecomputedEarthPos = float3(0.0, 6360010.0, 0.0);
			static const float _Azure_Precomputed_RES_MU = 128.0;
			static const float _Azure_Precomputed_RES_R = 32.0;
			static const float _Azure_Precomputed_RES_MU_S = 32.0;
			static const float _Azure_Precomputed_RES_NU = 8.0;

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

			float3 SkyRadiance(float3 camera, float3 viewdir, float3 lightdir, float lightIntensity, out float3 extinction, float3 skyColor)
			{
				camera += _Azure_PrecomputedEarthPos;

			   	float3 result = float3(0,0,0);
			   	extinction = float3(1,1,1);
			   	
			    float r = length(camera);
			    float rMu = dot(camera, viewdir);
			    float rMu2 = dot(camera, float3(viewdir.x, abs(viewdir.y), viewdir.z));
			    float mu = rMu / r;
			    float r0 = r;
			    float mu0 = mu;

			    float deltaSq = sqrt(rMu * rMu - r * r + _Azure_PrecomputedRt*_Azure_PrecomputedRt);
			    float din = max(-rMu - deltaSq, 0.0);
			    if (din > 0.0) 
			    {
			       	camera += din * viewdir;
			       	rMu += din;
			       	mu = rMu / _Azure_PrecomputedRt;
			       	r = _Azure_PrecomputedRt;
			    }
			    
			    float nu = dot(viewdir, lightdir);
			    float muS = dot(camera, lightdir) / r;

			    //float4 inScatter = Texture4D(_Precomputed_Inscatter, r, abs(rMu) / r, muS, nu);
			    rMu = _Azure_PrecomputedSkyGround ? abs(rMu) : rMu;
			    float4 inScatter = Texture4D(_Precomputed_Inscatter, r, rMu / r, muS, nu);
			    extinction = Transmittance(r, mu);

			    if(r <= _Azure_PrecomputedRt)
			    {
			        float3 inScatterM = GetMie(inScatter);
			        float phase = PhaseFunctionR(nu);
			        float phaseM = PhaseFunctionM(nu);
			        result = inScatter.rgb * phase + inScatterM * phaseM;
			    }

			    return result * skyColor * lightIntensity;
			}

			float3 SunGlare(float3 sundir)
			{
			    float3 data = sundir.z > 0.0 ? tex2D(_Azure_PrecomputedSunGlare, float2(0.5,0.5) + sundir.xy * 4.0).rgb : float3(0,0,0);
			    return pow(max(0,data), 2.2) * _Azure_PrecomputedSunIntensity;
			}

			//-------------------------------------------------------------------------------------------------------
			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f 
			{
    			float4 Position     : SV_POSITION;
    			float3 WorldPos     : TEXCOORD0;
    			float3 StarfieldPos : TEXCOORD1;
				float3 MoonPos      : TEXCOORD2;
				float3 NoiseRot     : TEXCOORD3;
				float3 SunPos       : TEXCOORD4;
			};

			v2f vert(appdata v)
			{
    			v2f o;
    			UNITY_INITIALIZE_OUTPUT(v2f, o);
    			o.Position = UnityObjectToClipPos(v.vertex);
    			//o.WorldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.WorldPos = normalize(mul((float3x3)unity_ObjectToWorld, v.vertex.xyz));

				//Matrix.
			    //-------------------------------------------------------------------------------------------------------
			    o.NoiseRot     = mul((float3x3)_Azure_NoiseMatrix,v.vertex.xyz);//Rotate noise texture to apply star scintillation
				o.StarfieldPos = mul((float3x3)_Azure_SunMatrix,v.vertex.xyz);
				o.StarfieldPos = mul((float3x3)_Azure_StarfieldMatrix, o.StarfieldPos);
			    o.SunPos       = mul((float3x3)_Azure_WtLSunMatrix, v.vertex.xyz);
			    o.MoonPos      = mul((float3x3)_Azure_MoonMatrix,v.vertex.xyz) * (25.0 * saturate(1.0 - _Azure_MoonDiskSize));
    			o.MoonPos.x   *= -1.0; //Invert x scale.

    			return o;
			}
			
			float4 frag(v2f IN) : SV_Target
			{
			    float3 viewDir  = normalize(IN.WorldPos + float3(0, 0.005, 0));
			    float3 skyColor = float3(0.0,0.0,0.0);
			    float r         = length(float3(0, _Azure_LightSpeed,0));
			    //float mask = saturate((viewDir.y) * -1000);
			    //return float4(mask,mask,mask,1);

			    //Sun Scattering.
			    //-------------------------------------------------------------------------------------------------------
				float3 extinction;
				float3 inscatter = SkyRadiance(_WorldSpaceCameraPos, viewDir, _Azure_SunDirection, _Azure_PrecomputedSunIntensity, extinction, float3(1.0, 1.0, 1.0));
				float3 nightSky = (1.0 - extinction) * _Azure_PrecomputedDeepDarkness;

				//Moon Scattering.
			    //-------------------------------------------------------------------------------------------------------
				float3 moonInscatter = SkyRadiance(_WorldSpaceCameraPos, viewDir, _Azure_MoonDirection, _Azure_PrecomputedMoonIntensity, extinction, _Azure_PrecomputedNightColor);
				nightSky += moonInscatter;

				//Solar Disk.
			    //-------------------------------------------------------------------------------------------------------
			    float  sunMask  = saturate(viewDir.y * 100);
			    float3 sunDisk  = min(2.0, pow((1.0 - dot(viewDir, _Azure_SunDirection)) * 500 , -1.5 )) * pow(extinction, 3.5) * _Azure_PrecomputedSunIntensity;
			    float3 sunGlare = SunGlare(IN.SunPos * -1.0);

			    sunDisk = lerp(saturate(sunDisk), sunGlare, 0) * viewDir.y;
			    sunDisk = lerp(sunDisk, float3(0,0,0), _PrecomputedSkyElevation) * 1.0;

			    //Starfield.
				//-------------------------------------------------------------------------------------------------------
				float  scintillation = texCUBE(_AzureStarNoiseTexture, IN.NoiseRot.xyz) * 2.0;
				float4 Starfield = texCUBE(_Azure_StarfieldTexture, IN.StarfieldPos.xyz);
				float3 Stars     = Starfield.rgb * Starfield.a * scintillation;
				float3 MilkyWay  = pow(Starfield.rgb, 1.5) * _Azure_MilkyWayIntensity;

				//Moon Bright.
				//-------------------------------------------------------------------------------------------------------
			    float  moonPosition = 1.0 + dot( viewDir, _Azure_MoonMatrix[2].xyz);
			    float3 moonBright   = 1.0 / (_Azure_MoonSkyBright  + moonPosition * _Azure_MoonSkyBrightRange)  * moonInscatter.rgb;
				       moonBright  += 1.0 / (_Azure_MoonDiskBright + moonPosition * _Azure_MoonDiskBrightRange) * moonInscatter.rgb;
//				float3 moonBright   = 1.0 / (_Azure_MoonSkyBright  + moonPosition * _Azure_MoonSkyBrightRange)  * _Azure_MoonSkyBrightColor.rgb;
//				       moonBright  += 1.0 / (_Azure_MoonDiskBright + moonPosition * _Azure_MoonDiskBrightRange) * _Azure_MoonDiskColor.rgb;

				//Moon.
				//-------------------------------------------------------------------------------------------------------
				float  moonFade    = saturate(dot(-_Azure_MoonMatrix[2].xyz,IN.WorldPos));//Fade other side moon.
				float2 scale = float2(1.0, 1.0);
			    float2 moonTex = tex2D( _Azure_MoonTexture, IN.MoonPos.xy /scale +0.5).ra;
			    float3 MoonColor    = (pow(float3(moonTex.r, moonTex.r, moonTex.r), 2.5) * (_Azure_MoonDiskColor.rgb * 2.0)) * extinction.b * moonFade;
			           MoonColor   *= 10.0;
			    float  moonMask     = 1.0 - saturate(moonTex.g * 10.0) * moonFade;//Fade behind the moon.
			    float moonRise  = saturate(dot(float3(0, 500,0), _Azure_MoonDirection) / r);
			    //return float4(moonTex.r, moonTex.r, moonTex.r, 1.0);

			    //Color Correction.
				#ifdef UNITY_COLORSPACE_GAMMA

				skyColor = inscatter + nightSky;
				skyColor += extinction * sunGlare + sunDisk;
				skyColor += max(0.0, moonBright * moonRise);
				skyColor += max(0.0,((((Stars + MilkyWay) * _Azure_StarfieldColorBalance) * extinction.b) * _Azure_StarfieldIntensity) * moonMask + MoonColor);
				skyColor = hdr(skyColor);

				#else

				skyColor = inscatter + nightSky;
				skyColor += extinction * sunGlare + sunDisk;
				skyColor += max(0.0, moonBright * moonRise);
				skyColor += max(0.0,((((Stars + MilkyWay) * _Azure_StarfieldColorBalance) * saturate(extinction.b * (viewDir.y + 0.1))) * _Azure_StarfieldIntensity) * moonMask + MoonColor);
				skyColor = hdr(skyColor);
				skyColor = GammaToLinearSpace (skyColor);//Whole Sky.

    			#endif
    			skyColor = pow(skyColor,_Azure_GammaCorrection);

    			//skyColor += (Stars + MilkyWay) * _Azure_StarfieldColorBalance * (extinction.b * (viewDir.y + 0.1)) * _Azure_StarfieldIntensity;
    			//skyColor += max(0.0,((((Stars + MilkyWay) * _Azure_StarfieldColorBalance) * saturate(extinction.b * (viewDir.y + 0.1))) * _Azure_StarfieldIntensity) * moonMask + MoonColor);
				
				return float4(skyColor, 1.0);
			}
			ENDCG
    	}
	}
}