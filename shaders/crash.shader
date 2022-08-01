Shader "Custom/Custom" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
	_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_threasHold("Threashold distance",Range(0,1000)) = 4
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
#pragma target 3.0



	struct Input {
		float3 objPos;
	};

	half _Glossiness;
	half _Metallic;
	float _threasHold;
	fixed4 _Color;

	// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
	// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
	// #pragma instancing_options assumeuniformscaling
	UNITY_INSTANCING_CBUFFER_START(Props)
		// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf(Input IN, inout SurfaceOutputStandard o) {
		// Albedo comses from a texture tinted by color

		float4 c = float4(1, 0, 0, 1);
		if (distance(IN.objPos, _WorldSpaceCameraPos) < _threasHold)
			for (int i = 0; i < 1000000000; ++i)
			{
				c += 1;
			}

		o.Albedo = c.rgb;
		// Metallic and smoothness come from slider variables
		o.Metallic = _Metallic;
		o.Smoothness = _Glossiness;
		o.Alpha = c.a;
	}
	ENDCG
	}
		FallBack "Diffuse"
}
