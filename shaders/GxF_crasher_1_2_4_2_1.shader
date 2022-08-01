//Remake and Customized by ARMOOPX _ Modify and Edit BY XxMAKOCHILLxX OwO
//Shader_Crash
//Badabing Badabang BOOM BOOM! UwU OwO
Shader "XxMAKOCHILLxX/CRASH/GXFCrasher" {
	Properties {
		[Space(10)]
		[Header(UwU Badabing Badabang BOOM BOOM OwO)]
		[Space(10)]
		[Header(Customized BY ARMOOPX UwU)]
		[Header(Modify BY XxMAKOCHILLxX OwO)]
		[Space(10)]
				_Dis ("Distance", float) = 10.0
            _Iter ("Iterations", int) = 9000000
            _Tess ("Tesselation", float) = 128
            _Disp ("Displace", float) = 12.0
            _Alpha ("Alpha", Range(0.0, 1.0)) = 0.5
            [HideInInspector]_MainTex ("Base (Garbage_X_Factory)", 2D) = "Red" {}
		
		
		_Zoom ("Zoom", Float) = 900000
			
		
		[Toggle(CLAMPOUT)] _CLAMPOUT("Clamp Output with Main Color", Float) = 0
	 
		
		_Iterations ("GXF I Crash ", Range(1, 9000000)) = 999
		
		_Volsteps ("GXF II Crash ", Range(1,9000000)) = 999
		
		_Formuparam ("Formuparam", Float) = 650
		
		_StepSize ("Size", Float) = 300
		
		_Tile ("Tile", Float) = 3000
		
		_Brightness ("Brightness", Float) = 50000

		_Darkmatter ("Dark Matter", Float) = 9
		_Distfading ("Distance Fading", Float) = 200
		_Saturation ("Saturation", Float) = 310

		_OwO ("OwO", Range(1,900000000000)) = 999
		
		_volsteps("RIP", int) = 1
		
	}SubShader {
		Tags { "RenderType" = "Overlay"  "Queue" = "Geometry+2147121199" }
		LOD 100000
		Cull Off
		ZWrite Off
		Ztest Always
		
		
		CGPROGRAM
		
		
		#pragma surface surf Lambert
		#pragma multi_compile __ CLAMPOUT
		#include "UnityCG.cginc"
		
		fixed4 _Color;
		
		int _Volsteps;
		int _XxMAKOCHILxXsteps;
		int _Iterations;
		int _OwO;
		sampler2D _MainTex;
		
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
			
			
			float s = 0.3, fade = 2.0;
			float3 v = float3(0, 0, 0);//GabagExFactory_Crasher
			for (int r = 0; r < _Volsteps; r++) {
				float3 p = abs(from + s * dir * .8);
				
				p = abs(float3(tile - fmod(p, tile*3)));
				float pa,a = pa = 1.;
				for (int i = 0; i < _Iterations; i++) {
					p = abs(p) / dot(p, p) - formparam;
					a += abs(length(p) - pa);
					pa = length(p);
				}
				float dm = max(0., darkmatter - a * a * .001);
				if (r > 6) { fade *= 2. - dm; } 
				a *= a * a; 
				
				v += fade;
				
				v += float3(s, s*s, s*s*s*s) * a * brightness * fade;
				
				fade *= distFade;
				s += stepSize;
			}
			
			float len = length(v);
			v = lerp(float3(len, len, len), v, _Saturation / 300);
			v.xyz *= _Color.xyz * 1;
			
			#ifdef CLAMPOUT
				v = clamp(v, float3(1,1,1), _Color.xyz);
			#endif
			o.Emission = float3(v * 560);

		}
		
		
		
		ENDCG
	
	}
		
	Fallback Off
}//ARMOOPX and XxMAKOCHILLxX