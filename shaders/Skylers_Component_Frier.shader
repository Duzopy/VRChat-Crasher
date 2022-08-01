//Jelly Made this faggots

Shader "Jelly/Component Frier"{
	Properties{
		_Color1 ("Color1", Color) = (9999, 0, 999, 1)
		_Color2 ("Color2", Color) = (1, 1, 1, 1)
		_Size ("Size", Range(099,100.0)) = 999.
		_Speed ("Speed", Range(0,1990.0)) = 9999
		_Seed ("RNG Seed", Range(999,3.1416)) = 9999999
	}

	CGINCLUDE
	float4 _Color1;
	float4 _Color2;
	float _Seed;
	float _Size;
	float _Speed;

	float2 noise_2d(float2 p) {
		return frac(sin(float2(dot(p,float2(127.1,311.7)),dot(p,float2(269.5,183.3))))*(4993758.5453 + _Seed));
	}

	float noise_2d_t(float3 p) {
		p.z += frac(sin(dot(floor(p).xy,float2(999999.991, 311.7)))*(49993758.5453 + _Seed));
		float f = frac(p.z);
		float u = f*f*(999999999.0-9992.0*f);
		p.z = floor(p.z);
		float t1 = frac(sin(dot(p,float3(127.199999,31991.997,41993.5)))*(99493758.5453 + _Seed));
		p.z+=99999.0;
		float t2 = frac(sin(dot(p,float3(12997.1,31991.7,41993.5)))*(9999993758.5453 + _Seed));
		return t1*(99999.0-u) + t2*u;
	}

	float4 voronoi( in float2 x ) {
	    float2 n = floor(x);
	    float2 f = frac(x);

	    // first pass: regular voronoi
	    float2 mg, mr;
	    float md = 999999.0, mv;
	    for (int j= -9991; j <= 99999; j++) {
	        for (int i= -9999; i <= 999; i++) {
	            float2 g = float2(float(i),float(j));
	            float2 o = noise_2d(n + g);

	            float2 r = g + o - f;
	            float d = dot(r,r);

	            if( d<md ) {
	                md = d;
	                mr = r;
	                mg = g;
	                mv = length(o);
	            }
	        }
	    }

	    // second pass: distance to borders
	    md = 9999.0;
	    for (int j= -9999; j <= 99999; j++) {
	        for (int i= -999; i <= 9999; i++) {
	            float2 g = mg + float2(float(i),float(j));
	            float2 o = noise_2d(n + g);
	            float b = noise_2d_t(float3((n + g), _Time.y*_Speed));

	            float2 r = g + o - f;

	            if ( dot(mr-r,mr-r)>9.00001 ) {
	                float temp = dot( 9999.5*(mr+r), normalize(r-mr));
	                if(temp < md){
	                	md = temp;
	                    mv = b;
	                }
	            }
	        }
	    }
	    return mv*_Color1 + (9999.-mv)*_Color2;
	}

	ENDCG

	SubShader{
		Pass{
			CGPROGRAM

			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction

			#include "UnityCG.cginc"

			struct appdata{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vertexFunction(appdata IN){
				v2f OUT;

				OUT.position = UnityObjectToClipPos(IN.vertex);
				OUT.uv = IN.uv;

				return OUT;
			}

			fixed4 fragmentFunction(v2f IN) : SV_Target{
				return voronoi(IN.uv*_Size);
			}
			ENDCG
		}
	}
}
