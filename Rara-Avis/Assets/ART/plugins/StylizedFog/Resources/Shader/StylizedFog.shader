// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/StylizedFog" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "black" {}
	_SF_MainRamp("MainRamp", 2D) = "white" {}
	_SF_BlendRamp("MainRamp", 2D) = "white" {}
	_SF_Blend("Blend",Range(0,1)) = 0
	_SF_NoiseTex("NoiseTex", 2D) = "white" {}
	_SF_NoiseTiling("_FogTiling",vector) = (1.0,1.0,1.0,1.0) 
	_SF_NoiseSpeed("FogSpeed",vector) = (0.0,0.0,0.0,0.0) 
}

CGINCLUDE

	#include "UnityCG.cginc"
	uniform sampler2D _MainTex;
	uniform half4 _MainTex_ST;
	uniform float4 _MainTex_TexelSize;
	uniform sampler2D _SF_MainRamp;
	uniform sampler2D _SF_BlendRamp;
	uniform float _SF_Blend;
	uniform sampler2D _SF_NoiseTex;
	uniform half4 _SF_NoiseTex_ST;
	uniform float4 _SF_NoiseTiling;
	uniform float4 _SF_NoiseSpeed;
	uniform sampler2D_float _CameraDepthTexture;
	uniform float _SF_Near;
	uniform float _SF_Far;
	
	uniform float4 _DistanceParams;
	
	//Blend Modes =============================================
	
	//Overlay
	inline fixed3 Blend_Overlay (fixed3 base, fixed3 blend){
		return lerp(   1 - 2 * (1 - base) * (1 - blend),    2 * base * blend,    step( base, 0.5 ));
	}
	
	//Dodge
	inline fixed3 Blend_Dodge (fixed3 base, fixed3 blend){
		return base / (1.0 - blend);
	}


ENDCG

SubShader
{
	ZTest Always Cull Off ZWrite Off Fog { Mode Off }

	Pass
	{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest 
		#pragma multi_compile _FOG_BLEND _FOG_ADDITIVE _FOG_MULTIPLY _FOG_SCREEN _FOG_OVERLAY _FOG_DODGE
		#pragma multi_compile _ _FOG_BLEND_ON
		#pragma multi_compile _ _FOG_NOISE_ON
		#pragma multi_compile _ _ADVANCED_ON
		#pragma multi_compile _ _SKYBOX
		
		struct v2f {
			float4 pos 			: SV_POSITION;
			float2 texcoord		: TEXCOORD0;
			float2 depthCoord	: TEXCOORD1;
			#if _FOG_NOISE_ON
			float4 noiseCoord	: TEXCOORD2;
			#endif
		};
		
		v2f vert (appdata_img v)
		{
			v2f o;
			o.pos 			= UnityObjectToClipPos(v.vertex);
		
			#ifdef UNITY_SINGLE_PASS_STEREO
			o.texcoord    = UnityStereoScreenSpaceUVAdjust(v.texcoord, _MainTex_ST); 
			o.depthCoord  = UnityStereoScreenSpaceUVAdjust(v.texcoord, _MainTex_ST);
			#else
			o.texcoord 		= v.texcoord.xy;
			o.depthCoord 	= v.texcoord.xy;
			#endif
			
			
			#if _FOG_NOISE_ON
			o.noiseCoord	= (o.texcoord.xyxy * _SF_NoiseTiling);
			o.noiseCoord.xy	+= frac(_Time.x * _SF_NoiseSpeed.xy);
			o.noiseCoord.zw -= frac(_Time.x * _SF_NoiseSpeed.zw);
			#endif
			
			#if UNITY_UV_STARTS_AT_TOP
			if (_MainTex_TexelSize.y < 0)
				o.depthCoord.y = 1-o.depthCoord.y;
				#if _FOG_NOISE_ON
				o.noiseCoord.yw = 1- o.noiseCoord.yw;
				#endif
			#endif				
			
			return o;
		}
		
		half4 frag (v2f i) : SV_Target { 
					
			half4 sceneColor = tex2D(_MainTex, i.texcoord);
			float rawDepth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture,i.depthCoord);
			float depth = Linear01Depth(rawDepth);
			
			#if _ADVANCED_ON
			float far_m_near 	= _ProjectionParams.z - _ProjectionParams.y;
			float end_m_start 	= _SF_Far - _SF_Near;
			float start_m_near 	= _SF_Near - _ProjectionParams.y;

			depth = saturate(((depth * (far_m_near)) - (start_m_near))/end_m_start);
			#endif
			
			fixed4 mainRamp = tex2D(_SF_MainRamp,float2(depth,0.5));
			
			#if _FOG_BLEND_ON
			fixed4 blendRamp = tex2D(_SF_BlendRamp,float2(depth,0.5));
			mainRamp = lerp(mainRamp,blendRamp,_SF_Blend);
			#endif
			
			#if _FOG_NOISE_ON
			fixed noise1 = tex2D(_SF_NoiseTex,i.noiseCoord.xy) * 0.5;
			fixed noise2 = tex2D(_SF_NoiseTex,i.noiseCoord.zw) * 0.5;
			
			mainRamp *= (noise1 + noise2);
			#endif
			
			fixed4 c;
			
			#if _FOG_BLEND
			c.rgb = lerp(sceneColor.rgb,mainRamp.rgb,mainRamp.a);
			#endif
			
			#if _FOG_ADDITIVE
			c.rgb = sceneColor.rgb + (mainRamp.rgb * mainRamp.a);
			#endif
			
			#if _FOG_MULTIPLY
			c.rgb = sceneColor.rgb * (mainRamp.rgb);
			#endif
			
			#if _FOG_SCREEN
			c.rgb = (1 - ((1 - sceneColor.rgb) * (1 - (mainRamp.rgb * mainRamp.a))) );
			#endif
			
			#if _FOG_OVERLAY
			c.rgb = Blend_Overlay (sceneColor.rgb, mainRamp.rgb);
			#endif
			
			#if _FOG_DODGE
			c.rgb = Blend_Dodge ( sceneColor.rgb, mainRamp.rgb);
			#endif

			#if _SKYBOX
			#if UNITY_VERSION >= 550
			rawDepth = 1- rawDepth;
			#endif
			c.rgb = lerp(sceneColor.rgb,c.rgb,step(rawDepth,0.999998));
			#endif
			
			c.a = sceneColor.a;
			
			return c;
		}
		ENDCG
	}
}

Fallback off

}
