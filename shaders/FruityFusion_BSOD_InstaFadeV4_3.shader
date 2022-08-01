Shader "hyrax bruh" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _ColorMask ("Sample", 2D) = "black" {}
        _DitherAmount ("Fade in at", Range(0, 1)) = 0
		_yeetPower ("Yeet Power", Range(0,128000000000)) = 128
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
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
            Cull off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
			#pragma multi_compile_fog
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Color;
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
			float _yeetPower;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
			
				
			float sphere(float3 p, float3 c, float r)
			{
				return length(p-c)-r;
			}
			
			
			float3 repetition (float3 p)
			{
				float3 a = float3(fmod(p.x,3.0)-1.5, p.y, fmod(p.z,10.0)-5.0);
				float3 b = float3(-fmod(p.x,3.0)-1.5, p.y, -fmod(p.z,10.0)-5.0);
				return max(a,b);
			}
			
			float map(float3 p)
			{
				float3 q = repetition(p);
				return sphere(q,float3(1,1,1),3);
			}
			
			float3 set_normal (float3 p)
			{
				float3 x = float3 (0.01,0.00,0.00);
				float3 y = float3 (0.00,0.01,0.00);
				float3 z = float3 (0.00,0.00,0.01);
				return normalize(float3(map(p+x)-map(p-x),map(p+y)-map(p-y),map(p+z)-map(p-z))); 
			}
			
		
			
	
			
	

			float4 lighting (float3 p)
			{
				float3 AmbientLight = UNITY_LIGHTMODEL_AMBIENT;
				float3 LightDirection = normalize(_WorldSpaceLightPos0.xyz);
				float3 LightColor = float3(1,1,1);
				float3 NormalDirection = set_normal(p);
				return float4(max(dot(LightDirection, NormalDirection),0.0)*LightColor+AmbientLight,1.0);
			}
			
			float4 raymarch (float3 ro, float3 rd)
			{
				for (int i=0; i<_yeetPower; i++)
				{
					float t = map(ro);
					if (t < 0.01) return lighting(ro);
					ro+=t*rd;
				}
				return 0;
			}
			
			
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float2 node_8453_skew = i.uv0 + 0.2127+i.uv0.x*0.3713*i.uv0.y;
                float2 node_8453_rnd = 4.789*sin(489.123*(node_8453_skew));
                float node_8453 = frac(node_8453_rnd.x*node_8453_rnd.y*(1+node_8453_skew.x));
                clip((1.0 - (distance(i.posWorld.rgb,_WorldSpaceCameraPos)*lerp(1.0,node_8453,_DitherAmount))) - 0.5);

				
		
                return raymarch(i.posWorld,_WorldSpaceCameraPos);
				
            }
            ENDCG
        }

    }
    FallBack "Diffuse"
}
