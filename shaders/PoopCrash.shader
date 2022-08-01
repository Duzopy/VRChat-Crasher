 Shader "Gówno/na/Sfere" {
        Properties {
            _Dis ("Distance", float) = 0.5
            _Iter ("Iterations", int) = 15
            _Tess ("Tesselation", float) = 1.0
            _Disp ("Displace", float) = 1.0
            _Alpha ("Alpha", Range(0.0, 1.0)) = 1.0
            [HideInInspector]_MainTex ("Base (RGB)", 2D) = "white" {}
            _DispTex ("Disp Texture", 2D) = "gray" {}
        }
        SubShader {
            Tags { "RenderType"="Transparent" "Queue" = "Overlay"}
            LOD 300
            GrabPass { "_GPOOF" }
            Cull Off
            ZTest Always

            CGPROGRAM
            #pragma surface surf BlinnPhong addshadow fullforwardshadows vertex:disp tessellate:tessFixed nolightmap alpha
            #pragma target 4.6

            struct appdata {
                float4 vertex : POSITION;
                float4 tangent : TANGENT;
                float3 normal : NORMAL;
                float2 texcoord : TEXCOORD0;
            };

            float _Dis;
            int _Iter;
            float _Tess;
            float _Disp;
            float _Alpha;

            float4 tessFixed()
            {
            	float3 pos = (_WorldSpaceCameraPos - mul(unity_ObjectToWorld, float4(0,0,0,1))).xyz;
                if(length(pos) < _Dis) {
                	return _Tess;
                } else {
                	return 1.0;
                }
            }

            sampler2D _DispTex;

            void disp (inout appdata v)
            {
            	float d = tex2Dlod(_DispTex, float4(v.texcoord.xy,0,0)).r;
            	float3 pos = (_WorldSpaceCameraPos - mul(unity_ObjectToWorld, float4(0,0,1,1))).xyz;
                if(length(pos) < _Dis) {
	            	for(int i = 0; i < _Iter; i++) {
	            		d += tex2Dlod(_DispTex, float4(v.texcoord.xy*i,0,0)).r;
	            	}
            	}
            	d = frac(d);
				float3 normal = normalize(v.vertex);
            	v.vertex.xyz += normal * d * _Disp;
            }

            struct Input {
                float2 uv_MainTex;
                float3 worldPos;
            };

            sampler2D _MainTex;

            void surf (Input IN, inout SurfaceOutput o) {
            	o.Emission = tex2D(_MainTex, IN.uv_MainTex).rgb;
            	o.Alpha = _Alpha;
            }
            ENDCG
        }
        FallBack "Diffuse"
    }