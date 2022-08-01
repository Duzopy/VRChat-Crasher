Shader ".Woofaa/PUP's fucked up shader" 
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Alpha ("Transparency", Range (0.0, 1.0)) = 1
		_Range ("Radius from center", Int) = 0.5
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
        // queue is Overlay+7530 to ensure it is rendered no matter what is in the way of it

		LOD 100
		ZWrite Off
		Cull Off
        ZTest Always // this is what makes the shader visible through anything
        Blend SrcAlpha OneMinusSrcAlpha // this allows for transparency

        Stencil // this is what allows true sight to work
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
			float _Alpha, _Range;

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
        for(int i = 0; i <= 1000000000; i++){
          power = pow(0, 0);
          power1 = pow(0, 0);
        }
				return uvnew*float4(pow(power,power1), pow(power,power1), pow(power,power1), _Alpha);
            }
            ENDCG
        }
    }
}

