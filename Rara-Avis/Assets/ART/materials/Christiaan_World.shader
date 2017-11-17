// Shader created with Shader Forge v1.37 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.37;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33346,y:32684,varname:node_4013,prsc:2|diff-6462-OUT,spec-4202-OUT,gloss-9604-OUT,normal-2583-OUT,difocc-7564-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:6806,x:29220,y:32941,varname:node_6806,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:9216,x:30632,y:31743,prsc:2,pt:False;n:type:ShaderForge.SFN_Abs,id:8586,x:31000,y:31744,varname:node_8586,prsc:2|IN-9216-OUT;n:type:ShaderForge.SFN_Multiply,id:8203,x:31241,y:31744,varname:node_8203,prsc:2|A-8586-OUT,B-8586-OUT;n:type:ShaderForge.SFN_ChannelBlend,id:5303,x:31875,y:32419,varname:node_5303,prsc:2,chbt:0|M-8203-OUT,R-9581-RGB,G-6143-RGB,B-2522-RGB;n:type:ShaderForge.SFN_Append,id:7355,x:29588,y:32807,varname:node_7355,prsc:2|A-6806-Y,B-6806-Z;n:type:ShaderForge.SFN_Append,id:2099,x:29588,y:32954,varname:node_2099,prsc:2|A-6806-Z,B-6806-X;n:type:ShaderForge.SFN_Append,id:4650,x:29588,y:33104,varname:node_4650,prsc:2|A-6806-X,B-6806-Y;n:type:ShaderForge.SFN_Multiply,id:5969,x:30623,y:32628,varname:node_5969,prsc:2|A-4650-OUT,B-251-OUT;n:type:ShaderForge.SFN_Multiply,id:237,x:30623,y:32469,varname:node_237,prsc:2|A-2099-OUT,B-251-OUT;n:type:ShaderForge.SFN_Multiply,id:5659,x:30623,y:32294,varname:node_5659,prsc:2|A-7355-OUT,B-251-OUT;n:type:ShaderForge.SFN_ValueProperty,id:251,x:30018,y:32731,ptovrint:False,ptlb:Texture_1_Scale,ptin:_Texture_1_Scale,varname:_Texture_1_Scale,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2d,id:9581,x:31014,y:31940,varname:node_9581,prsc:2,ntxv:0,isnm:False|UVIN-5659-OUT,TEX-3575-TEX;n:type:ShaderForge.SFN_Tex2d,id:6143,x:31025,y:32091,varname:node_6143,prsc:2,ntxv:0,isnm:False|UVIN-237-OUT,TEX-3575-TEX;n:type:ShaderForge.SFN_Tex2d,id:2522,x:31036,y:32248,varname:node_2522,prsc:2,ntxv:0,isnm:False|UVIN-5969-OUT,TEX-3575-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:3575,x:30018,y:32108,ptovrint:False,ptlb:Texture_1_Colour,ptin:_Texture_1_Colour,varname:_Texture_1_Colour,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2dAsset,id:8494,x:30018,y:32316,ptovrint:False,ptlb:Texture_1_Normal,ptin:_Texture_1_Normal,varname:_Texture_1_Normal,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_ChannelBlend,id:2761,x:31875,y:32591,varname:node_2761,prsc:2,chbt:0|M-8203-OUT,R-5803-RGB,G-5849-RGB,B-1219-RGB;n:type:ShaderForge.SFN_Tex2d,id:5803,x:31036,y:32415,varname:node_5803,prsc:2,ntxv:0,isnm:False|UVIN-5659-OUT,TEX-8494-TEX;n:type:ShaderForge.SFN_Tex2d,id:5849,x:31024,y:32564,varname:node_5849,prsc:2,ntxv:0,isnm:False|UVIN-237-OUT,TEX-8494-TEX;n:type:ShaderForge.SFN_Tex2d,id:1219,x:31024,y:32695,varname:node_1219,prsc:2,ntxv:0,isnm:False|UVIN-5969-OUT,TEX-8494-TEX;n:type:ShaderForge.SFN_Multiply,id:6765,x:30735,y:33658,varname:node_6765,prsc:2|A-4650-OUT,B-1011-OUT;n:type:ShaderForge.SFN_Multiply,id:7864,x:30735,y:33510,varname:node_7864,prsc:2|A-2099-OUT,B-1011-OUT;n:type:ShaderForge.SFN_Multiply,id:9067,x:30749,y:33363,varname:node_9067,prsc:2|A-7355-OUT,B-1011-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1011,x:30171,y:33876,ptovrint:True,ptlb:Texture_2_Scale,ptin:_Texture_2_Scale,varname:_Texture_2_Scale,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2dAsset,id:3112,x:30158,y:34000,ptovrint:True,ptlb:Texture_2_Colour,ptin:_Texture_2_Colour,varname:_Texture_2_Colour,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:2296,x:30991,y:33618,varname:node_2296,prsc:2,ntxv:0,isnm:False|UVIN-9067-OUT,TEX-3112-TEX;n:type:ShaderForge.SFN_Tex2d,id:9711,x:30991,y:33803,varname:node_9711,prsc:2,ntxv:0,isnm:False|UVIN-7864-OUT,TEX-3112-TEX;n:type:ShaderForge.SFN_Tex2d,id:8453,x:30991,y:33985,varname:node_8453,prsc:2,ntxv:0,isnm:False|UVIN-6765-OUT,TEX-3112-TEX;n:type:ShaderForge.SFN_Tex2d,id:9737,x:30991,y:34153,varname:node_9738,prsc:2,ntxv:0,isnm:False|UVIN-9067-OUT,TEX-7334-TEX;n:type:ShaderForge.SFN_Tex2d,id:6081,x:30991,y:34324,varname:node_6082,prsc:2,ntxv:0,isnm:False|UVIN-7864-OUT,TEX-7334-TEX;n:type:ShaderForge.SFN_Tex2d,id:6353,x:30984,y:34508,varname:node_6354,prsc:2,ntxv:0,isnm:False|UVIN-6765-OUT,TEX-7334-TEX;n:type:ShaderForge.SFN_ChannelBlend,id:9589,x:31874,y:33350,varname:node_9589,prsc:2,chbt:0|M-8203-OUT,R-2296-RGB,G-9711-RGB,B-8453-RGB;n:type:ShaderForge.SFN_ChannelBlend,id:9588,x:31874,y:33536,varname:node_9588,prsc:2,chbt:0|M-8203-OUT,R-9737-RGB,G-6081-RGB,B-6353-RGB;n:type:ShaderForge.SFN_Lerp,id:4432,x:32289,y:32430,cmnt:BaseColourBlend_REDVERT,varname:node_4432,prsc:2|A-5303-OUT,B-9589-OUT,T-7899-R;n:type:ShaderForge.SFN_VertexColor,id:7899,x:31859,y:33134,varname:node_7899,prsc:2;n:type:ShaderForge.SFN_Lerp,id:9716,x:32238,y:33235,cmnt:NormalBlend_RedVert,varname:node_9716,prsc:2|A-2761-OUT,B-9588-OUT,T-7899-R;n:type:ShaderForge.SFN_Tex2dAsset,id:2277,x:30018,y:32522,ptovrint:False,ptlb:Texture_1_Roughness,ptin:_Texture_1_Roughness,varname:_Texture_1_Roughness,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ChannelBlend,id:5839,x:31875,y:32766,varname:node_5839,prsc:2,chbt:0|M-8203-OUT,R-2701-RGB,G-4053-RGB,B-6651-RGB;n:type:ShaderForge.SFN_Lerp,id:1582,x:32286,y:32793,cmnt:RoughnessBlend_REDVERT,varname:node_1582,prsc:2|A-5839-OUT,B-7445-OUT,T-7899-R;n:type:ShaderForge.SFN_ChannelBlend,id:7445,x:31874,y:33708,varname:node_7445,prsc:2,chbt:0|M-8203-OUT,R-9635-RGB,G-8040-RGB,B-1915-RGB;n:type:ShaderForge.SFN_ComponentMask,id:9046,x:32750,y:32788,varname:node_9046,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-3188-OUT;n:type:ShaderForge.SFN_Vector1,id:5327,x:32651,y:32984,varname:node_5327,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:9604,x:32892,y:32788,varname:node_9604,prsc:2|A-9046-OUT,B-5327-OUT;n:type:ShaderForge.SFN_ChannelBlend,id:528,x:31875,y:32929,varname:node_528,prsc:2,chbt:0|M-8203-OUT,R-9581-A,G-6143-A,B-2522-A;n:type:ShaderForge.SFN_ChannelBlend,id:2193,x:31874,y:33924,varname:node_2193,prsc:2,chbt:0|M-8203-OUT,R-2296-A,G-9711-A,B-8453-A;n:type:ShaderForge.SFN_Lerp,id:3512,x:32469,y:33662,cmnt:AO_Blend_REDVERT,varname:node_3512,prsc:2|A-528-OUT,B-2193-OUT,T-7899-R;n:type:ShaderForge.SFN_Vector1,id:4202,x:32683,y:32690,varname:node_4202,prsc:2,v1:0;n:type:ShaderForge.SFN_Tex2dAsset,id:7334,x:30158,y:34203,ptovrint:True,ptlb:Texture_2_Normal,ptin:_Texture_2_Normal,varname:_Texture_2_Normal,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2dAsset,id:873,x:30158,y:34449,ptovrint:True,ptlb:Texture_2_Roughness,ptin:_Texture_2_Roughness,varname:_Texture_2_Roughness,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:2701,x:31024,y:32876,varname:node_2701,prsc:2,ntxv:0,isnm:False|UVIN-5659-OUT,TEX-2277-TEX;n:type:ShaderForge.SFN_Tex2d,id:4053,x:31023,y:33043,varname:node_4053,prsc:2,ntxv:0,isnm:False|UVIN-237-OUT,TEX-2277-TEX;n:type:ShaderForge.SFN_Tex2d,id:6651,x:31023,y:33227,varname:node_6651,prsc:2,ntxv:0,isnm:False|UVIN-5969-OUT,TEX-2277-TEX;n:type:ShaderForge.SFN_Tex2d,id:9635,x:30984,y:34665,varname:node_9636,prsc:2,ntxv:0,isnm:False|UVIN-9067-OUT,TEX-873-TEX;n:type:ShaderForge.SFN_Tex2d,id:8040,x:30984,y:34861,varname:node_8041,prsc:2,ntxv:0,isnm:False|UVIN-7864-OUT,TEX-873-TEX;n:type:ShaderForge.SFN_Tex2d,id:1915,x:30984,y:35064,varname:node_1916,prsc:2,ntxv:0,isnm:False|UVIN-6765-OUT,TEX-873-TEX;n:type:ShaderForge.SFN_Multiply,id:7250,x:30717,y:35269,varname:node_7250,prsc:2|A-4650-OUT,B-7883-OUT;n:type:ShaderForge.SFN_Multiply,id:6104,x:30717,y:35121,varname:node_6104,prsc:2|A-2099-OUT,B-7883-OUT;n:type:ShaderForge.SFN_Multiply,id:29,x:30731,y:34974,varname:node_29,prsc:2|A-7355-OUT,B-7883-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7883,x:30153,y:35487,ptovrint:True,ptlb:Texture_3_Tiling,ptin:_Texture_3_Scale,varname:_Texture_3_Scale,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Tex2dAsset,id:745,x:30140,y:35611,ptovrint:True,ptlb:Texture_3_BaseColour,ptin:_Texture_3_Colour,varname:_Texture_3_Colour,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:9728,x:30984,y:35249,varname:node_2297,prsc:2,ntxv:0,isnm:False|UVIN-29-OUT,TEX-745-TEX;n:type:ShaderForge.SFN_Tex2d,id:5722,x:30973,y:35414,varname:node_9712,prsc:2,ntxv:0,isnm:False|UVIN-6104-OUT,TEX-745-TEX;n:type:ShaderForge.SFN_Tex2d,id:8071,x:30973,y:35596,varname:node_8457,prsc:2,ntxv:0,isnm:False|UVIN-7250-OUT,TEX-745-TEX;n:type:ShaderForge.SFN_Tex2d,id:3389,x:30973,y:35764,varname:node_9737,prsc:2,ntxv:0,isnm:False|UVIN-29-OUT,TEX-6650-TEX;n:type:ShaderForge.SFN_Tex2d,id:7226,x:30973,y:35935,varname:node_6081,prsc:2,ntxv:0,isnm:False|UVIN-6104-OUT,TEX-6650-TEX;n:type:ShaderForge.SFN_Tex2d,id:6893,x:30966,y:36119,varname:node_6353,prsc:2,ntxv:0,isnm:False|UVIN-7250-OUT,TEX-6650-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:6650,x:30140,y:35814,ptovrint:True,ptlb:Texture_3_Normal,ptin:_Texture_3_Normal,varname:_Texture_3_Normal,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2dAsset,id:9507,x:30140,y:36060,ptovrint:True,ptlb:Texture_3_Roughness,ptin:_Texture_3_Roughness,varname:_Texture_3_Roughness,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:114,x:30966,y:36276,varname:node_9635,prsc:2,ntxv:0,isnm:False|UVIN-29-OUT,TEX-9507-TEX;n:type:ShaderForge.SFN_Tex2d,id:9938,x:30966,y:36472,varname:node_8040,prsc:2,ntxv:0,isnm:False|UVIN-6104-OUT,TEX-9507-TEX;n:type:ShaderForge.SFN_Tex2d,id:5509,x:30966,y:36675,varname:node_1915,prsc:2,ntxv:0,isnm:False|UVIN-7250-OUT,TEX-9507-TEX;n:type:ShaderForge.SFN_ChannelBlend,id:5367,x:31669,y:35365,cmnt:CompTexture3_Colour,varname:node_5367,prsc:2,chbt:0|M-8203-OUT,R-9728-RGB,G-5722-RGB,B-8071-RGB;n:type:ShaderForge.SFN_ChannelBlend,id:3315,x:31669,y:35571,cmnt:CompTexture_3_Normal,varname:node_3315,prsc:2,chbt:0|M-8203-OUT,R-3389-RGB,G-7226-RGB,B-6893-RGB;n:type:ShaderForge.SFN_ChannelBlend,id:2229,x:31669,y:35770,cmnt:CompTexture_3_Rough,varname:node_2229,prsc:2,chbt:0|M-8203-OUT,R-114-RGB,G-9938-RGB,B-5509-RGB;n:type:ShaderForge.SFN_Lerp,id:6462,x:32662,y:32457,cmnt:BaseColourBlend_REDVERT,varname:node_6462,prsc:2|A-4432-OUT,B-5367-OUT,T-7899-G;n:type:ShaderForge.SFN_Lerp,id:2583,x:32564,y:33266,cmnt:NormalBlend_GREENVERT,varname:node_2583,prsc:2|A-9716-OUT,B-3315-OUT,T-7899-G;n:type:ShaderForge.SFN_Lerp,id:3188,x:32504,y:32816,cmnt:RoughnessBlend_GREENVERT,varname:node_3188,prsc:2|A-1582-OUT,B-2229-OUT,T-7899-G;n:type:ShaderForge.SFN_ChannelBlend,id:3331,x:31689,y:35146,cmnt:CompTexture_3_Ao,varname:node_3331,prsc:2,chbt:0|M-8203-OUT,R-9728-A,G-5722-A,B-8071-A;n:type:ShaderForge.SFN_Lerp,id:7564,x:32705,y:33662,varname:node_7564,prsc:2|A-3512-OUT,B-3331-OUT,T-7899-G;proporder:3575-8494-2277-251-3112-1011-7334-873-745-6650-9507-7883;pass:END;sub:END;*/

Shader "Shader Forge/Christiaan_World" {
    Properties {
        _Texture_1_Colour ("Texture_1_Colour", 2D) = "white" {}
        _Texture_1_Normal ("Texture_1_Normal", 2D) = "bump" {}
        _Texture_1_Roughness ("Texture_1_Roughness", 2D) = "white" {}
        _Texture_1_Scale ("Texture_1_Scale", Float ) = 1
        _Texture_2_Colour ("Texture_2_Colour", 2D) = "white" {}
        _Texture_2_Scale ("Texture_2_Scale", Float ) = 1
        _Texture_2_Normal ("Texture_2_Normal", 2D) = "bump" {}
        _Texture_2_Roughness ("Texture_2_Roughness", 2D) = "white" {}
        _Texture_3_Colour ("Texture_3_BaseColour", 2D) = "white" {}
        _Texture_3_Normal ("Texture_3_Normal", 2D) = "bump" {}
        _Texture_3_Roughness ("Texture_3_Roughness", 2D) = "white" {}
        _Texture_3_Scale ("Texture_3_Tiling", Float ) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _Texture_1_Scale;
            uniform sampler2D _Texture_1_Colour; uniform float4 _Texture_1_Colour_ST;
            uniform sampler2D _Texture_1_Normal; uniform float4 _Texture_1_Normal_ST;
            uniform float _Texture_2_Scale;
            uniform sampler2D _Texture_2_Colour; uniform float4 _Texture_2_Colour_ST;
            uniform sampler2D _Texture_1_Roughness; uniform float4 _Texture_1_Roughness_ST;
            uniform sampler2D _Texture_2_Normal; uniform float4 _Texture_2_Normal_ST;
            uniform sampler2D _Texture_2_Roughness; uniform float4 _Texture_2_Roughness_ST;
            uniform float _Texture_3_Scale;
            uniform sampler2D _Texture_3_Colour; uniform float4 _Texture_3_Colour_ST;
            uniform sampler2D _Texture_3_Normal; uniform float4 _Texture_3_Normal_ST;
            uniform sampler2D _Texture_3_Roughness; uniform float4 _Texture_3_Roughness_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float3 tangentDir : TEXCOORD2;
                float3 bitangentDir : TEXCOORD3;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(4,5)
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 node_8586 = abs(i.normalDir);
                float3 node_8203 = (node_8586*node_8586);
                float2 node_7355 = float2(i.posWorld.g,i.posWorld.b);
                float2 node_5659 = (node_7355*_Texture_1_Scale);
                float3 node_5803 = UnpackNormal(tex2D(_Texture_1_Normal,TRANSFORM_TEX(node_5659, _Texture_1_Normal)));
                float2 node_2099 = float2(i.posWorld.b,i.posWorld.r);
                float2 node_237 = (node_2099*_Texture_1_Scale);
                float3 node_5849 = UnpackNormal(tex2D(_Texture_1_Normal,TRANSFORM_TEX(node_237, _Texture_1_Normal)));
                float2 node_4650 = float2(i.posWorld.r,i.posWorld.g);
                float2 node_5969 = (node_4650*_Texture_1_Scale);
                float3 node_1219 = UnpackNormal(tex2D(_Texture_1_Normal,TRANSFORM_TEX(node_5969, _Texture_1_Normal)));
                float2 node_9067 = (node_7355*_Texture_2_Scale);
                float3 node_9738 = UnpackNormal(tex2D(_Texture_2_Normal,TRANSFORM_TEX(node_9067, _Texture_2_Normal)));
                float2 node_7864 = (node_2099*_Texture_2_Scale);
                float3 node_6082 = UnpackNormal(tex2D(_Texture_2_Normal,TRANSFORM_TEX(node_7864, _Texture_2_Normal)));
                float2 node_6765 = (node_4650*_Texture_2_Scale);
                float3 node_6354 = UnpackNormal(tex2D(_Texture_2_Normal,TRANSFORM_TEX(node_6765, _Texture_2_Normal)));
                float2 node_29 = (node_7355*_Texture_3_Scale);
                float3 node_9737 = UnpackNormal(tex2D(_Texture_3_Normal,TRANSFORM_TEX(node_29, _Texture_3_Normal)));
                float2 node_6104 = (node_2099*_Texture_3_Scale);
                float3 node_6081 = UnpackNormal(tex2D(_Texture_3_Normal,TRANSFORM_TEX(node_6104, _Texture_3_Normal)));
                float2 node_7250 = (node_4650*_Texture_3_Scale);
                float3 node_6353 = UnpackNormal(tex2D(_Texture_3_Normal,TRANSFORM_TEX(node_7250, _Texture_3_Normal)));
                float3 normalLocal = lerp(lerp((node_8203.r*node_5803.rgb + node_8203.g*node_5849.rgb + node_8203.b*node_1219.rgb),(node_8203.r*node_9738.rgb + node_8203.g*node_6082.rgb + node_8203.b*node_6354.rgb),i.vertexColor.r),(node_8203.r*node_9737.rgb + node_8203.g*node_6081.rgb + node_8203.b*node_6353.rgb),i.vertexColor.g);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 node_2701 = tex2D(_Texture_1_Roughness,TRANSFORM_TEX(node_5659, _Texture_1_Roughness));
                float4 node_4053 = tex2D(_Texture_1_Roughness,TRANSFORM_TEX(node_237, _Texture_1_Roughness));
                float4 node_6651 = tex2D(_Texture_1_Roughness,TRANSFORM_TEX(node_5969, _Texture_1_Roughness));
                float4 node_9636 = tex2D(_Texture_2_Roughness,TRANSFORM_TEX(node_9067, _Texture_2_Roughness));
                float4 node_8041 = tex2D(_Texture_2_Roughness,TRANSFORM_TEX(node_7864, _Texture_2_Roughness));
                float4 node_1916 = tex2D(_Texture_2_Roughness,TRANSFORM_TEX(node_6765, _Texture_2_Roughness));
                float4 node_9635 = tex2D(_Texture_3_Roughness,TRANSFORM_TEX(node_29, _Texture_3_Roughness));
                float4 node_8040 = tex2D(_Texture_3_Roughness,TRANSFORM_TEX(node_6104, _Texture_3_Roughness));
                float4 node_1915 = tex2D(_Texture_3_Roughness,TRANSFORM_TEX(node_7250, _Texture_3_Roughness));
                float gloss = (lerp(lerp((node_8203.r*node_2701.rgb + node_8203.g*node_4053.rgb + node_8203.b*node_6651.rgb),(node_8203.r*node_9636.rgb + node_8203.g*node_8041.rgb + node_8203.b*node_1916.rgb),i.vertexColor.r),(node_8203.r*node_9635.rgb + node_8203.g*node_8040.rgb + node_8203.b*node_1915.rgb),i.vertexColor.g).r*(-1.0));
                float perceptualRoughness = 1.0 - (lerp(lerp((node_8203.r*node_2701.rgb + node_8203.g*node_4053.rgb + node_8203.b*node_6651.rgb),(node_8203.r*node_9636.rgb + node_8203.g*node_8041.rgb + node_8203.b*node_1916.rgb),i.vertexColor.r),(node_8203.r*node_9635.rgb + node_8203.g*node_8040.rgb + node_8203.b*node_1915.rgb),i.vertexColor.g).r*(-1.0));
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = 0.0;
                float specularMonochrome;
                float4 node_9581 = tex2D(_Texture_1_Colour,TRANSFORM_TEX(node_5659, _Texture_1_Colour));
                float4 node_6143 = tex2D(_Texture_1_Colour,TRANSFORM_TEX(node_237, _Texture_1_Colour));
                float4 node_2522 = tex2D(_Texture_1_Colour,TRANSFORM_TEX(node_5969, _Texture_1_Colour));
                float4 node_2296 = tex2D(_Texture_2_Colour,TRANSFORM_TEX(node_9067, _Texture_2_Colour));
                float4 node_9711 = tex2D(_Texture_2_Colour,TRANSFORM_TEX(node_7864, _Texture_2_Colour));
                float4 node_8453 = tex2D(_Texture_2_Colour,TRANSFORM_TEX(node_6765, _Texture_2_Colour));
                float4 node_2297 = tex2D(_Texture_3_Colour,TRANSFORM_TEX(node_29, _Texture_3_Colour));
                float4 node_9712 = tex2D(_Texture_3_Colour,TRANSFORM_TEX(node_6104, _Texture_3_Colour));
                float4 node_8457 = tex2D(_Texture_3_Colour,TRANSFORM_TEX(node_7250, _Texture_3_Colour));
                float3 diffuseColor = lerp(lerp((node_8203.r*node_9581.rgb + node_8203.g*node_6143.rgb + node_8203.b*node_2522.rgb),(node_8203.r*node_2296.rgb + node_8203.g*node_9711.rgb + node_8203.b*node_8453.rgb),i.vertexColor.r),(node_8203.r*node_2297.rgb + node_8203.g*node_9712.rgb + node_8203.b*node_8457.rgb),i.vertexColor.g); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                indirectDiffuse *= lerp(lerp((node_8203.r*node_9581.a + node_8203.g*node_6143.a + node_8203.b*node_2522.a),(node_8203.r*node_2296.a + node_8203.g*node_9711.a + node_8203.b*node_8453.a),i.vertexColor.r),(node_8203.r*node_2297.a + node_8203.g*node_9712.a + node_8203.b*node_8457.a),i.vertexColor.g); // Diffuse AO
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _Texture_1_Scale;
            uniform sampler2D _Texture_1_Colour; uniform float4 _Texture_1_Colour_ST;
            uniform sampler2D _Texture_1_Normal; uniform float4 _Texture_1_Normal_ST;
            uniform float _Texture_2_Scale;
            uniform sampler2D _Texture_2_Colour; uniform float4 _Texture_2_Colour_ST;
            uniform sampler2D _Texture_1_Roughness; uniform float4 _Texture_1_Roughness_ST;
            uniform sampler2D _Texture_2_Normal; uniform float4 _Texture_2_Normal_ST;
            uniform sampler2D _Texture_2_Roughness; uniform float4 _Texture_2_Roughness_ST;
            uniform float _Texture_3_Scale;
            uniform sampler2D _Texture_3_Colour; uniform float4 _Texture_3_Colour_ST;
            uniform sampler2D _Texture_3_Normal; uniform float4 _Texture_3_Normal_ST;
            uniform sampler2D _Texture_3_Roughness; uniform float4 _Texture_3_Roughness_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float3 tangentDir : TEXCOORD2;
                float3 bitangentDir : TEXCOORD3;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(4,5)
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 node_8586 = abs(i.normalDir);
                float3 node_8203 = (node_8586*node_8586);
                float2 node_7355 = float2(i.posWorld.g,i.posWorld.b);
                float2 node_5659 = (node_7355*_Texture_1_Scale);
                float3 node_5803 = UnpackNormal(tex2D(_Texture_1_Normal,TRANSFORM_TEX(node_5659, _Texture_1_Normal)));
                float2 node_2099 = float2(i.posWorld.b,i.posWorld.r);
                float2 node_237 = (node_2099*_Texture_1_Scale);
                float3 node_5849 = UnpackNormal(tex2D(_Texture_1_Normal,TRANSFORM_TEX(node_237, _Texture_1_Normal)));
                float2 node_4650 = float2(i.posWorld.r,i.posWorld.g);
                float2 node_5969 = (node_4650*_Texture_1_Scale);
                float3 node_1219 = UnpackNormal(tex2D(_Texture_1_Normal,TRANSFORM_TEX(node_5969, _Texture_1_Normal)));
                float2 node_9067 = (node_7355*_Texture_2_Scale);
                float3 node_9738 = UnpackNormal(tex2D(_Texture_2_Normal,TRANSFORM_TEX(node_9067, _Texture_2_Normal)));
                float2 node_7864 = (node_2099*_Texture_2_Scale);
                float3 node_6082 = UnpackNormal(tex2D(_Texture_2_Normal,TRANSFORM_TEX(node_7864, _Texture_2_Normal)));
                float2 node_6765 = (node_4650*_Texture_2_Scale);
                float3 node_6354 = UnpackNormal(tex2D(_Texture_2_Normal,TRANSFORM_TEX(node_6765, _Texture_2_Normal)));
                float2 node_29 = (node_7355*_Texture_3_Scale);
                float3 node_9737 = UnpackNormal(tex2D(_Texture_3_Normal,TRANSFORM_TEX(node_29, _Texture_3_Normal)));
                float2 node_6104 = (node_2099*_Texture_3_Scale);
                float3 node_6081 = UnpackNormal(tex2D(_Texture_3_Normal,TRANSFORM_TEX(node_6104, _Texture_3_Normal)));
                float2 node_7250 = (node_4650*_Texture_3_Scale);
                float3 node_6353 = UnpackNormal(tex2D(_Texture_3_Normal,TRANSFORM_TEX(node_7250, _Texture_3_Normal)));
                float3 normalLocal = lerp(lerp((node_8203.r*node_5803.rgb + node_8203.g*node_5849.rgb + node_8203.b*node_1219.rgb),(node_8203.r*node_9738.rgb + node_8203.g*node_6082.rgb + node_8203.b*node_6354.rgb),i.vertexColor.r),(node_8203.r*node_9737.rgb + node_8203.g*node_6081.rgb + node_8203.b*node_6353.rgb),i.vertexColor.g);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 node_2701 = tex2D(_Texture_1_Roughness,TRANSFORM_TEX(node_5659, _Texture_1_Roughness));
                float4 node_4053 = tex2D(_Texture_1_Roughness,TRANSFORM_TEX(node_237, _Texture_1_Roughness));
                float4 node_6651 = tex2D(_Texture_1_Roughness,TRANSFORM_TEX(node_5969, _Texture_1_Roughness));
                float4 node_9636 = tex2D(_Texture_2_Roughness,TRANSFORM_TEX(node_9067, _Texture_2_Roughness));
                float4 node_8041 = tex2D(_Texture_2_Roughness,TRANSFORM_TEX(node_7864, _Texture_2_Roughness));
                float4 node_1916 = tex2D(_Texture_2_Roughness,TRANSFORM_TEX(node_6765, _Texture_2_Roughness));
                float4 node_9635 = tex2D(_Texture_3_Roughness,TRANSFORM_TEX(node_29, _Texture_3_Roughness));
                float4 node_8040 = tex2D(_Texture_3_Roughness,TRANSFORM_TEX(node_6104, _Texture_3_Roughness));
                float4 node_1915 = tex2D(_Texture_3_Roughness,TRANSFORM_TEX(node_7250, _Texture_3_Roughness));
                float gloss = (lerp(lerp((node_8203.r*node_2701.rgb + node_8203.g*node_4053.rgb + node_8203.b*node_6651.rgb),(node_8203.r*node_9636.rgb + node_8203.g*node_8041.rgb + node_8203.b*node_1916.rgb),i.vertexColor.r),(node_8203.r*node_9635.rgb + node_8203.g*node_8040.rgb + node_8203.b*node_1915.rgb),i.vertexColor.g).r*(-1.0));
                float perceptualRoughness = 1.0 - (lerp(lerp((node_8203.r*node_2701.rgb + node_8203.g*node_4053.rgb + node_8203.b*node_6651.rgb),(node_8203.r*node_9636.rgb + node_8203.g*node_8041.rgb + node_8203.b*node_1916.rgb),i.vertexColor.r),(node_8203.r*node_9635.rgb + node_8203.g*node_8040.rgb + node_8203.b*node_1915.rgb),i.vertexColor.g).r*(-1.0));
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = 0.0;
                float specularMonochrome;
                float4 node_9581 = tex2D(_Texture_1_Colour,TRANSFORM_TEX(node_5659, _Texture_1_Colour));
                float4 node_6143 = tex2D(_Texture_1_Colour,TRANSFORM_TEX(node_237, _Texture_1_Colour));
                float4 node_2522 = tex2D(_Texture_1_Colour,TRANSFORM_TEX(node_5969, _Texture_1_Colour));
                float4 node_2296 = tex2D(_Texture_2_Colour,TRANSFORM_TEX(node_9067, _Texture_2_Colour));
                float4 node_9711 = tex2D(_Texture_2_Colour,TRANSFORM_TEX(node_7864, _Texture_2_Colour));
                float4 node_8453 = tex2D(_Texture_2_Colour,TRANSFORM_TEX(node_6765, _Texture_2_Colour));
                float4 node_2297 = tex2D(_Texture_3_Colour,TRANSFORM_TEX(node_29, _Texture_3_Colour));
                float4 node_9712 = tex2D(_Texture_3_Colour,TRANSFORM_TEX(node_6104, _Texture_3_Colour));
                float4 node_8457 = tex2D(_Texture_3_Colour,TRANSFORM_TEX(node_7250, _Texture_3_Colour));
                float3 diffuseColor = lerp(lerp((node_8203.r*node_9581.rgb + node_8203.g*node_6143.rgb + node_8203.b*node_2522.rgb),(node_8203.r*node_2296.rgb + node_8203.g*node_9711.rgb + node_8203.b*node_8453.rgb),i.vertexColor.r),(node_8203.r*node_2297.rgb + node_8203.g*node_9712.rgb + node_8203.b*node_8457.rgb),i.vertexColor.g); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
