Shader "!Devloli/Crash" {
	Properties {
		_MainTex ("Texture Sampler (UV Only)", 3D) = "grey" {}		
		_Zoom ("Zoom", Float) = 99999999999		
		_Color ("Main Color", Color) = (1,1,1,1)			
		[Toggle(CLAMPOUT)] _CLAMPOUT("Clamp Output with Main Color", Float) = 0		
		_Scroll ("Scrolling direction (x,y,z) * w * time", Vector) = (3, 1, .6, .01)		
		_Center ("Center Position (x, y, z, time)", Vector) = (1, .3, .5, 0)		
		_Rotation ("Rotation (x,y,z)*w angles", Vector) = (35, 25, 75, .1)		
		[HideInInspector]_Iterations ("crash Valor", Range(1, 3000)) = 3000		
		[HideInInspector]_Volsteps ("2 Crash Valor 2", Range(1,4000)) = 4000		
		_Formuparam ("Formuparam", Float) = 599		
		_StepSize ("Step Size", Float) = 130
		_Tile ("Tile", Float) = 700
		_Brightness ("Brightness", Float) = 2
		_Darkmatter ("Dark Matter", Float) = 25
		_Distfading ("Distance Fading", Float) = 68
		_Saturation ("Saturation", Float) = 85
		
	}

	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }
		Cull Off
		ZWrite Off
		Ztest Always
		
		
		CGPROGRAM
		
		
		#pragma surface surf Lambert
		#pragma multi_compile __ CLAMPOUT
		#include "UnityCG.cginc"
		
		fixed4 _Color;
		
		int _Volsteps;
		int _Iterations;
		sampler3D _MainTex;
		
		float4 _Scroll;
		float4 _Center;
		float _CamScroll;
		float4 _Rotation;
		
		float _Formuparam;
		float _StepSize;
		
		float _Zoom;
		
		float _Tile;
		
		float _Brightness;
		float _Darkmatter;
		float _Distfading;
		float _Saturation;
		
		struct Input {
			float2 uv_MainTex;
		};
		
		
		
		void surf (Input IN, inout SurfaceOutput o) {
			half3 col = half3(0, 0, 0);
			float zoom = _Zoom / 1000;
			float2 uv = IN.uv_MainTex;
			uv -= .5;
			
			half3 dir = float3(uv * zoom, 1);
			
			float time = _Center.w + _Time.x;
			
			float brightness = _Brightness / 1000;
			float stepSize = _StepSize / 1000;
			float3 tile = abs(float3(_Tile, _Tile, _Tile)) / 1000;
			float formparam = _Formuparam / 1000;
			
			float darkmatter = _Darkmatter / 100;
			float distFade = _Distfading / 100;
			
			float3 from = _Center.xyz;
			
			from += _Scroll.xyz * _Scroll.w * time;
			
			
			float3 rot = _Rotation.xyz * _Rotation.w;
			if (length(rot) > 0) {
				float2x2 rx = float2x2(cos(rot.x), sin(rot.x), -sin(rot.x), cos(rot.x));
				float2x2 ry = float2x2(cos(rot.y), sin(rot.y), -sin(rot.y), cos(rot.y));
				float2x2 rz = float2x2(cos(rot.z), sin(rot.z), -sin(rot.z), cos(rot.z));
				
				dir.xy = mul(rz, dir.xy);
				dir.xz = mul(ry, dir.xz);
				dir.yz = mul(rx, dir.yz);
				from.xy = mul(rz, from.xy);
				from.xz = mul(ry, from.xz);
				from.yz = mul(rx, from.yz);
			}
			
			
			float s = 0.1, fade = 1.0;
			float3 v = float3(0, 0, 0);
			for (int r = 0; r < _Volsteps; r++) {
				float3 p = abs(from + s * dir * .5);
				
				p = abs(float3(tile - fmod(p, tile*2)));
				float pa,a = pa = 0.;
				for (int i = 0; i < _Iterations; i++) {
					p = abs(p) / dot(p, p) - formparam;
					a += abs(length(p) - pa);
					pa = length(p);
				}
				float dm = max(0., darkmatter - a * a * .001);
				if (r > 6) { fade *= 1. - dm; }
				a *= a * a;
				
				v += fade;
				
				v += float3(s, s*s, s*s*s*s) * a * brightness * fade;
				
				fade *= distFade;
				s += stepSize;
			}
			
			float len = length(v);
			v = lerp(float3(len, len, len), v, _Saturation / 100);
			v.xyz *= _Color.xyz * .01;
			
			#ifdef CLAMPOUT
				v = clamp(v, float3(0,0,0), _Color.xyz);
			#endif
			o.Emission = float3(v * .01);
		}
		
		
		
		ENDCG
	
	}

	Fallback Off
}
