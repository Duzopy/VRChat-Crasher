Shader "VRChat/Mobile/Diffuse" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		LOD 150
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			LOD 150
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
			GpuProgramID 5524
			Program "vp" {
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					int u_xlati0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu0 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					int u_xlati0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu0 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					int u_xlati0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu0 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati3 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 1)];
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati3] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 2)] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 3)] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati3 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 1)];
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati3] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 2)] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 3)] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati3 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 1)];
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati3] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 2)] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 3)] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
					    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
					    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
					    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					int u_xlati0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu0 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
					    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
					    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					int u_xlati0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu0 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
					    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
					    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					int u_xlati0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu0 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_3 = u_xlat0.y * u_xlat0.y;
					    u_xlat16_3 = u_xlat0.x * u_xlat0.x + (-u_xlat16_3);
					    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					int u_xlati5;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati5 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati5 + 1)];
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati5] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati5 + 2)] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati5 + 3)] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat5.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_3 = u_xlat5.y * u_xlat5.y;
					    u_xlat16_3 = u_xlat5.x * u_xlat5.x + (-u_xlat16_3);
					    u_xlat16_1 = u_xlat5.yzzx * u_xlat5.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					int u_xlati5;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati5 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati5 + 1)];
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati5] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati5 + 2)] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati5 + 3)] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat5.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_3 = u_xlat5.y * u_xlat5.y;
					    u_xlat16_3 = u_xlat5.x * u_xlat5.x + (-u_xlat16_3);
					    u_xlat16_1 = u_xlat5.yzzx * u_xlat5.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					int u_xlati5;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati5 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati5 + 1)];
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati5] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati5 + 2)] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati5 + 3)] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat5.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat16_3 = u_xlat5.y * u_xlat5.y;
					    u_xlat16_3 = u_xlat5.x * u_xlat5.x + (-u_xlat16_3);
					    u_xlat16_1 = u_xlat5.yzzx * u_xlat5.xyzz;
					    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					int u_xlati0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu0 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					int u_xlati0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu0 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					int u_xlati0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati0 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati0 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu0 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu0)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati3 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 1)];
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati3] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 2)] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 3)] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati3 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 1)];
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati3] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 2)] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 3)] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati3 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 1)];
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati3] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 2)] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati3 + 3)] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat3 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    vs_TEXCOORD1.xyz = vec3(u_xlat3) * u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_7;
					void main()
					{
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_7 = max(u_xlat16_7, 0.0);
					    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					int u_xlati21;
					uint u_xlatu21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati21 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati21 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati21] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati21 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati21 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu21 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu21)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					int u_xlati21;
					uint u_xlatu21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati21 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati21 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati21] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati21 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati21 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu21 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu21)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "STEREO_MULTIVIEW_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_OVR_multiview2 : require
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					layout(std140) uniform UnityStereoEyeIndices {
						vec4 unity_StereoEyeIndices[2];
					};
					layout(num_views = 2) in;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_BLENDWEIGHT0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					float u_xlat21;
					int u_xlati21;
					uint u_xlatu21;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlati21 = int(int(gl_ViewID_OVR) << 2);
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati21 + 1)];
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati21] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati21 + 2)] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati21 + 3)] * u_xlat1.wwww + u_xlat2;
					    u_xlatu21 = gl_ViewID_OVR;
					    vs_BLENDWEIGHT0 = unity_StereoEyeIndices[int(u_xlatu21)].x;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
					    u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
					    u_xlat16_1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat16_5.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					vec3 u_xlat7;
					int u_xlati7;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati7 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati7 + 1)];
					    u_xlat3 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati7] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati7 + 2)] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati7 + 3)] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.x = inversesqrt(u_xlat7.x);
					    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat7.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat7.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat7.xxxx + u_xlat4;
					    u_xlat2 = u_xlat1 * u_xlat7.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat16_5.x = u_xlat7.y * u_xlat7.y;
					    u_xlat16_5.x = u_xlat7.x * u_xlat7.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat7.yzzx * u_xlat7.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz + u_xlat16_5.xyz;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					vec3 u_xlat7;
					int u_xlati7;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati7 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati7 + 1)];
					    u_xlat3 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati7] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati7 + 2)] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati7 + 3)] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.x = inversesqrt(u_xlat7.x);
					    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat7.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat7.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat7.xxxx + u_xlat4;
					    u_xlat2 = u_xlat1 * u_xlat7.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat16_5.x = u_xlat7.y * u_xlat7.y;
					    u_xlat16_5.x = u_xlat7.x * u_xlat7.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat7.yzzx * u_xlat7.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz + u_xlat16_5.xyz;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "STEREO_INSTANCING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					#extension GL_AMD_vertex_shader_layer : require
					
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					layout(std140) uniform UnityStereoGlobals {
						vec4 hlslcc_mtx4x4unity_StereoMatrixP[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixInvV[8];
						vec4 hlslcc_mtx4x4unity_StereoMatrixVP[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraInvProjection[8];
						vec4 hlslcc_mtx4x4unity_StereoWorldToCamera[8];
						vec4 hlslcc_mtx4x4unity_StereoCameraToWorld[8];
						vec3 unity_StereoWorldSpaceCameraPos[2];
						vec4 unity_StereoScaleOffset[2];
					};
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD3;
					flat out highp uint vs_SV_InstanceID0;
					flat out highp uint vs_BLENDINDICES0;
					float u_xlat0;
					uint u_xlatu0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump vec4 u_xlat16_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					mediump vec3 u_xlat16_5;
					mediump vec3 u_xlat16_6;
					vec3 u_xlat7;
					int u_xlati7;
					void main()
					{
					    u_xlat0 = float(uint(gl_InstanceID));
					    u_xlat0 = u_xlat0 * 0.5;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = roundEven(u_xlat0);
					    u_xlatu0 = uint(u_xlat0);
					    u_xlati7 = int(int(u_xlatu0) << 2);
					    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati7 + 1)];
					    u_xlat3 = hlslcc_mtx4x4unity_StereoMatrixVP[u_xlati7] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati7 + 2)] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = hlslcc_mtx4x4unity_StereoMatrixVP[(u_xlati7 + 3)] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat7.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat7.x = inversesqrt(u_xlat7.x);
					    u_xlat7.xyz = u_xlat7.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat7.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat2 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat7.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat7.xxxx + u_xlat4;
					    u_xlat2 = u_xlat1 * u_xlat7.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat16_5.x = u_xlat7.y * u_xlat7.y;
					    u_xlat16_5.x = u_xlat7.x * u_xlat7.x + (-u_xlat16_5.x);
					    u_xlat16_2 = u_xlat7.yzzx * u_xlat7.xyzz;
					    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
					    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
					    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
					    u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz + u_xlat16_5.xyz;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    gl_Layer = int(u_xlatu0);
					    vs_BLENDINDICES0 = u_xlatu0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					uniform 	mediump vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 _LightColor0;
					uniform mediump sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD3;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_10;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD1.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
					    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
					    u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
					    u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat16_10 = max(u_xlat16_10, 0.0);
					    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "STEREO_MULTIVIEW_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "STEREO_MULTIVIEW_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "STEREO_MULTIVIEW_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "STEREO_INSTANCING_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "STEREO_INSTANCING_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "STEREO_INSTANCING_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_MULTIVIEW_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_MULTIVIEW_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_MULTIVIEW_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_INSTANCING_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_INSTANCING_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "STEREO_INSTANCING_ON" }
					"!!GLES3"
				}
			}
		}
	}
	Fallback "Diffuse"
}