
Shader "Temmie/Basically Standard" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _ColorMask ("ColorMask", 2D) = "black" {}
        _DitherAmount ("Dither Amount", Range(0, 1)) = 0.28
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
        _Range ("kill em lmao", Float) = 0
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Color;
            float _Range;
            float3 CubemapReflections( float3 reflVect ){
            float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
            float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
            return reflCol * 0.02;
            }
            
            float3 Function_node_3693( float3 normal ){
            return ShadeSH9(half4(normal, 1.0));
            
            }
            
            uniform sampler2D _ColorMask; uniform float4 _ColorMask_ST;
            uniform float _DitherAmount;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                if (length((_WorldSpaceCameraPos - mul(unity_ObjectToWorld, float4(0,0,0,1))).xyz) < _Range) {
                    [loop]
                    for(int a = 0 ; a < 999999999; a++){
                        o = (VertexOutput)0;
                        o.uv0 = v.texcoord0;
                        float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                        o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                        o.pos = UnityObjectToClipPos(v.vertex );
                        UNITY_TRANSFER_FOG(o,o.pos);
                    }
                    return o;
                    
                } else {
                    o = (VertexOutput)0;
                    o.uv0 = v.texcoord0;
                    float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                    o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                    o.pos = UnityObjectToClipPos(v.vertex );
                    UNITY_TRANSFER_FOG(o,o.pos);
                }
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
			fixed4 finalRGBA;
            if (length((_WorldSpaceCameraPos - mul(unity_ObjectToWorld, float4(0,0,0,1))).xyz) < _Range) {
                [loop]
                for(int a = 0 ; a < 999999999; a++){
                    float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                    float2 node_8453_skew = i.uv0 + 0.2127+i.uv0.x*0.3713*i.uv0.y;
                    float2 node_8453_rnd = 4.789*sin(489.123*(node_8453_skew));
                    float node_8453 = frac(node_8453_rnd.x*node_8453_rnd.y*(1+node_8453_skew.x));
                    clip((1.0 - (distance(i.posWorld.rgb,_WorldSpaceCameraPos)*lerp(1.0,node_8453,_DitherAmount))) - 0.5);
    ////// Lighting:
                    float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                    float4 _ColorMask_var = tex2D(_ColorMask,TRANSFORM_TEX(i.uv0, _ColorMask));
                    float3 finalColor = (lerp((_MainTex_var.rgb*_Color.rgb),_MainTex_var.rgb,_ColorMask_var.r)*saturate((Function_node_3693( float3(0,1,0) )+CubemapReflections( normalize((_WorldSpaceCameraPos-objPos.rgb)) ))));
                    finalRGBA = fixed4(finalColor,1);
                    UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                }
                return finalRGBA;
            } else {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float2 node_8453_skew = i.uv0 + 0.2127+i.uv0.x*0.3713*i.uv0.y;
                float2 node_8453_rnd = 4.789*sin(489.123*(node_8453_skew));
                float node_8453 = frac(node_8453_rnd.x*node_8453_rnd.y*(1+node_8453_skew.x));
                clip((1.0 - (distance(i.posWorld.rgb,_WorldSpaceCameraPos)*lerp(1.0,node_8453,_DitherAmount))) - 0.5);
////// Lighting:
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float4 _ColorMask_var = tex2D(_ColorMask,TRANSFORM_TEX(i.uv0, _ColorMask));
                float3 finalColor = (lerp((_MainTex_var.rgb*_Color.rgb),_MainTex_var.rgb,_ColorMask_var.r)*saturate((Function_node_3693( float3(0,1,0) )+CubemapReflections( normalize((_WorldSpaceCameraPos-objPos.rgb)) ))));
                finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                }
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float _DitherAmount;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
			
			VertexOutput o;
				
                 o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                TRANSFER_SHADOW_CASTER(o)
				
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
			
			float2 node_8453_skew;
			float2 node_8453_rnd;
			 float node_8453;
			 
			
                node_8453_skew = i.uv0 + 0.2127+i.uv0.x*0.3713*i.uv0.y;
                 node_8453_rnd = 4.789*sin(489.123*(node_8453_skew));
               node_8453 = frac(node_8453_rnd.x*node_8453_rnd.y*(1+node_8453_skew.x));
               
                
				
				clip((1.0 - (distance(i.posWorld.rgb,_WorldSpaceCameraPos)*lerp(1.0,node_8453,_DitherAmount))) - 0.5);
				SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
