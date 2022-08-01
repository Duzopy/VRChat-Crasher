Shader "✞" {
    Properties {
		[Header(Distance Based Tesselation Done Right)]
		[Header(Can be used for lag or crash)]
		[Header(Made by Herpu)]
		
        _Distance ("Distance", Float ) = 1
		_Tesssize ("Size of tess cube generated", Range(0,500) ) = 100
	//	_Alphamult ("Alpha Multiplier", Range(0.000001,0.1) ) = 0.005
		_Alphamult ("Alpha Multiplier", Float ) = 0.005
		
        _safe ("Texture", 2D) = "black" {}
        [HideInInspector]_Strength ("Strength", Float ) = 0.01
        _Cutoff ("Alpha cutoff", Range(0,1)) = 1
		
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
			"Queue" = "Overlay+160000000"
			"RenderType" = "TransparentCutout+160000000"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Off
            Blend One One
            CGPROGRAM
            #pragma hull hull
            #pragma domain domain
            #pragma vertex tessvert
            #pragma fragment frag
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "Tessellation.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 5.0
            // Dithering function, to use with scene UVs (screen pixel coords)
            // 4x4 Bayer matrix, based on https://en.wikipedia.org/wiki/Ordered_dithering
            float BinaryDither4x4( float value, float2 sceneUVs ) {
                float4x4 mtx = float4x4(
                    float4( 1,  9,  3, 11 )/17.0,
                    float4( 13, 5, 15,  7 )/17.0,
                    float4( 4, 12,  2, 10 )/17.0,
                    float4( 16, 8, 14,  6 )/17.0
                );
                float2 px = floor(_ScreenParams.xy * sceneUVs);
                int xSmp = fmod(px.x,4);
                int ySmp = fmod(px.y,4);
                float4 xVec = 1-saturate(abs(float4(0,1,2,3) - xSmp));
                float4 yVec = 1-saturate(abs(float4(0,1,2,3) - ySmp));
                float4 pxMult = float4( dot(mtx[0],yVec), dot(mtx[1],yVec), dot(mtx[2],yVec), dot(mtx[3],yVec) );
                return round(value + dot(pxMult, xVec));
            }
            uniform float _Distance;
            uniform float _Tesssize;
            uniform sampler2D _safe; uniform float4 _safe_ST;
            uniform float _Strength;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float4 projPos : TEXCOORD4;
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                float node_998_if_leA = step(node_1793,_Distance);
                float node_998_if_leB = step(_Distance,node_1793);
                float node_3832 = _Tesssize;
                float node_3289 = 0.0;
                float node_3883 = 2.0;
                float4 node_2531 = _Time;
                float node_5613 = (node_2531.a*_Strength);
                float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                float2 node_4219 = (o.uv0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                float node_6802 = (node_2531.b*_Strength);
                float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                float2 node_2352 = (o.uv0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                float node_6559 = (node_2531.g*_Strength);
                float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                float2 node_1387 = (o.uv0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                float3 node_956 = (lerp((node_998_if_leA*node_3832)+(node_998_if_leB*node_3289),node_3832,node_998_if_leA*node_998_if_leB)*node_9066);
                v.vertex.xyz += node_956;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float node_5423_if_leA = step(node_1793,_Distance);
                float node_5423_if_leB = step(_Distance,node_1793);
                float node_6161 = (node_2531.r*10.0);
                float2 node_9214_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_9214_ty = floor(node_6161 * node_9214_tc_rcp.x);
                float node_9214_tx = node_6161 - node_3883 * node_9214_ty;
                float2 node_9214 = (o.uv0 + float2(node_9214_tx, node_9214_ty)) * node_9214_tc_rcp;
                float2 node_3565_skew = node_9214 + 0.2127+node_9214.x*0.3713*node_9214.y;
                float2 node_3565_rnd = 4.789*sin(489.123*(node_3565_skew));
                float node_3565 = frac(node_3565_rnd.x*node_3565_rnd.y*(1+node_3565_skew.x));
                float node_2883 = (node_3565*2.0+-1.0);
                float node_5811 = 1.0;
                float node_5423 = lerp((node_5423_if_leA*node_2883)+(node_5423_if_leB*node_5811),node_2883,node_5423_if_leA*node_5423_if_leB);
                float node_8216 = 1.0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + normalize(v.vertex)*(node_5423-node_8216),1) );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            #ifdef UNITY_CAN_COMPILE_TESSELLATION
                struct TessVertex {
                    float4 vertex : INTERNALTESSPOS;
                    float3 normal : NORMAL;
                    float4 tangent : TANGENT;
                    float2 texcoord0 : TEXCOORD0;
                    float2 texcoord1 : TEXCOORD1;
                    float2 texcoord2 : TEXCOORD2;
                };
                struct OutputPatchConstant {
                    float edge[3]         : SV_TessFactor;
                    float inside          : SV_InsideTessFactor;
                    float3 vTangent[4]    : TANGENT;
                    float2 vUV[4]         : TEXCOORD;
                    float3 vTanUCorner[4] : TANUCORNER;
                    float3 vTanVCorner[4] : TANVCORNER;
                    float4 vCWts          : TANWEIGHTS;
                };
                TessVertex tessvert (VertexInput v) {
                    TessVertex o;
                    o.vertex = v.vertex;
                    o.normal = v.normal;
                    o.tangent = v.tangent;
                    o.texcoord0 = v.texcoord0;
                    o.texcoord1 = v.texcoord1;
                    o.texcoord2 = v.texcoord2;
                    return o;
                }
                void displacement (inout VertexInput v){
                    float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                    float node_998_if_leA = step(node_1793,_Distance);
                    float node_998_if_leB = step(_Distance,node_1793);
                    float node_3832 = _Tesssize;
                    float node_3289 = 0.0;
                    float node_3883 = 2.0;
                    float4 node_2531 = _Time;
                    float node_5613 = (node_2531.a*_Strength);
                    float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                    float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                    float2 node_4219 = (v.texcoord0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                    float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                    float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                    float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                    float node_6802 = (node_2531.b*_Strength);
                    float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                    float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                    float2 node_2352 = (v.texcoord0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                    float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                    float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                    float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                    float node_6559 = (node_2531.g*_Strength);
                    float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                    float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                    float2 node_1387 = (v.texcoord0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                    float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                    float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                    float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                    float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                    float3 node_956 = (lerp((node_998_if_leA*node_3832)+(node_998_if_leB*node_3289),node_3832,node_998_if_leA*node_998_if_leB)*node_9066);
                    v.vertex.xyz += node_956;
                }
                float Tessellation(TessVertex v){
                    float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                    float node_6208_if_leA = step(node_1793,_Distance);
                    float node_6208_if_leB = step(_Distance,node_1793);
                    float node_2680 = 1000000.0;
                    float node_3289 = 0.0;
                    float node_3883 = 2.0;
                    float4 node_2531 = _Time;
                    float node_5613 = (node_2531.a*_Strength);
                    float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                    float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                    float2 node_4219 = (v.texcoord0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                    float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                    float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                    float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                    float node_5811 = 1.0;
                    return ((lerp((node_6208_if_leA*node_2680)+(node_6208_if_leB*node_3289),node_2680,node_6208_if_leA*node_6208_if_leB)*node_1347)+node_5811);
                }
                float4 Tessellation(TessVertex v, TessVertex v1, TessVertex v2){
                    float tv = Tessellation(v);
                    float tv1 = Tessellation(v1);
                    float tv2 = Tessellation(v2);
                    return float4( tv1+tv2, tv2+tv, tv+tv1, tv+tv1+tv2 ) / float4(2,2,2,3);
                }
                OutputPatchConstant hullconst (InputPatch<TessVertex,3> v) {
                    OutputPatchConstant o = (OutputPatchConstant)0;
                    float4 ts = Tessellation( v[0], v[1], v[2] );
                    o.edge[0] = ts.x;
                    o.edge[1] = ts.y;
                    o.edge[2] = ts.z;
                    o.inside = ts.w;
                    return o;
                }
                [domain("tri")]
                [partitioning("fractional_odd")]
                [outputtopology("triangle_cw")]
                [patchconstantfunc("hullconst")]
                [outputcontrolpoints(3)]
                TessVertex hull (InputPatch<TessVertex,3> v, uint id : SV_OutputControlPointID) {
                    return v[id];
                }
                [domain("tri")]
                VertexOutput domain (OutputPatchConstant tessFactors, const OutputPatch<TessVertex,3> vi, float3 bary : SV_DomainLocation) {
                    VertexInput v = (VertexInput)0;
                    v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
                    v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
                    v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
                    v.texcoord0 = vi[0].texcoord0*bary.x + vi[1].texcoord0*bary.y + vi[2].texcoord0*bary.z;
                    v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
                    displacement(v);
                    VertexOutput o = vert(v);
                    return o;
                }
            #endif
            float4 frag(VertexOutput i) : COLOR {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float node_1793 = distance(i.posWorld.rgb,_WorldSpaceCameraPos);
                float node_5423_if_leA = step(node_1793,_Distance);
                float node_5423_if_leB = step(_Distance,node_1793);
                float node_3883 = 2.0;
                float4 node_2531 = _Time;
                float node_6161 = (node_2531.r*10.0);
                float2 node_9214_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_9214_ty = floor(node_6161 * node_9214_tc_rcp.x);
                float node_9214_tx = node_6161 - node_3883 * node_9214_ty;
                float2 node_9214 = (i.uv0 + float2(node_9214_tx, node_9214_ty)) * node_9214_tc_rcp;
                float2 node_3565_skew = node_9214 + 0.2127+node_9214.x*0.3713*node_9214.y;
                float2 node_3565_rnd = 4.789*sin(489.123*(node_3565_skew));
                float node_3565 = frac(node_3565_rnd.x*node_3565_rnd.y*(1+node_3565_skew.x));
                float node_2883 = (node_3565*2.0+-1.0);
                float node_5811 = 1.0;
                float node_5423 = lerp((node_5423_if_leA*node_2883)+(node_5423_if_leB*node_5811),node_2883,node_5423_if_leA*node_5423_if_leB);
                clip( BinaryDither4x4(node_5423 - 1.5, sceneUVs) );
                float node_6133_if_leA = step(node_1793,_Distance);
                float node_6133_if_leB = step(_Distance,node_1793);
                float node_5613 = (node_2531.a*_Strength);
                float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                float2 node_4219 = (i.uv0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                float node_6802 = (node_2531.b*_Strength);
                float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                float2 node_2352 = (i.uv0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                float node_6559 = (node_2531.g*_Strength);
                float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                float2 node_1387 = (i.uv0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                float node_8216 = 1.0;
                float3 node_9205 = (node_9066*node_8216);
                float4 _safe_var = tex2D(_safe,TRANSFORM_TEX(i.uv0, _safe));
                float3 node_6133 = lerp((node_6133_if_leA*node_9205)+(node_6133_if_leB*_safe_var.rgb),node_9205,node_6133_if_leA*node_6133_if_leB);
                return fixed4(node_6133,0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One One
            ZTest Always
            Cull Off
            
            AlphaToMask On
            CGPROGRAM
            #pragma hull hull
            #pragma domain domain
            #pragma vertex tessvert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "Tessellation.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 5.0
            // Dithering function, to use with scene UVs (screen pixel coords)
            // 4x4 Bayer matrix, based on https://en.wikipedia.org/wiki/Ordered_dithering
            float BinaryDither4x4( float value, float2 sceneUVs ) {
                float4x4 mtx = float4x4(
                    float4( 1,  9,  3, 11 )/17.0,
                    float4( 13, 5, 15,  7 )/17.0,
                    float4( 4, 12,  2, 10 )/17.0,
                    float4( 16, 8, 14,  6 )/17.0
                );
                float2 px = floor(_ScreenParams.xy * sceneUVs);
                int xSmp = fmod(px.x,4);
                int ySmp = fmod(px.y,4);
                float4 xVec = 1-saturate(abs(float4(0,1,2,3) - xSmp));
                float4 yVec = 1-saturate(abs(float4(0,1,2,3) - ySmp));
                float4 pxMult = float4( dot(mtx[0],yVec), dot(mtx[1],yVec), dot(mtx[2],yVec), dot(mtx[3],yVec) );
                return round(value + dot(pxMult, xVec));
            }
            uniform float _Distance;
			uniform float _Tesssize;
            uniform sampler2D _safe; uniform float4 _safe_ST;
            uniform float _Strength;
			uniform float _Alphamult;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                float4 projPos : TEXCOORD7;
                UNITY_FOG_COORDS(8)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD9;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                float node_998_if_leA = step(node_1793,_Distance);
                float node_998_if_leB = step(_Distance,node_1793);
                float node_3832 = _Tesssize;
                float node_3289 = 0.0;
                float node_3883 = 2.0;
                float4 node_2531 = _Time;
                float node_5613 = (node_2531.a*_Strength);
                float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                float2 node_4219 = (o.uv0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                float node_6802 = (node_2531.b*_Strength);
                float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                float2 node_2352 = (o.uv0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                float node_6559 = (node_2531.g*_Strength);
                float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                float2 node_1387 = (o.uv0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                float3 node_956 = (lerp((node_998_if_leA*node_3832)+(node_998_if_leB*node_3289),node_3832,node_998_if_leA*node_998_if_leB)*node_9066);
                v.vertex.xyz += node_956;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            #ifdef UNITY_CAN_COMPILE_TESSELLATION
                struct TessVertex {
                    float4 vertex : INTERNALTESSPOS;
                    float3 normal : NORMAL;
                    float4 tangent : TANGENT;
                    float2 texcoord0 : TEXCOORD0;
                    float2 texcoord1 : TEXCOORD1;
                    float2 texcoord2 : TEXCOORD2;
                };
                struct OutputPatchConstant {
                    float edge[3]         : SV_TessFactor;
                    float inside          : SV_InsideTessFactor;
                    float3 vTangent[4]    : TANGENT;
                    float2 vUV[4]         : TEXCOORD;
                    float3 vTanUCorner[4] : TANUCORNER;
                    float3 vTanVCorner[4] : TANVCORNER;
                    float4 vCWts          : TANWEIGHTS;
                };
                TessVertex tessvert (VertexInput v) {
                    TessVertex o;
                    o.vertex = v.vertex;
                    o.normal = v.normal;
                    o.tangent = v.tangent;
                    o.texcoord0 = v.texcoord0;
                    o.texcoord1 = v.texcoord1;
                    o.texcoord2 = v.texcoord2;
                    return o;
                }
                void displacement (inout VertexInput v){
                    float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                    float node_998_if_leA = step(node_1793,_Distance);
                    float node_998_if_leB = step(_Distance,node_1793);
                    float node_3832 = _Tesssize;
                    float node_3289 = 0.0;
                    float node_3883 = 2.0;
                    float4 node_2531 = _Time;
                    float node_5613 = (node_2531.a*_Strength);
                    float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                    float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                    float2 node_4219 = (v.texcoord0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                    float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                    float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                    float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                    float node_6802 = (node_2531.b*_Strength);
                    float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                    float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                    float2 node_2352 = (v.texcoord0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                    float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                    float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                    float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                    float node_6559 = (node_2531.g*_Strength);
                    float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                    float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                    float2 node_1387 = (v.texcoord0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                    float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                    float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                    float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                    float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                    float3 node_956 = (lerp((node_998_if_leA*node_3832)+(node_998_if_leB*node_3289),node_3832,node_998_if_leA*node_998_if_leB)*node_9066);
                    v.vertex.xyz += node_956;
                }
                float Tessellation(TessVertex v){
                    float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                    float node_6208_if_leA = step(node_1793,_Distance);
                    float node_6208_if_leB = step(_Distance,node_1793);
                    float node_2680 = 1000000.0;
                    float node_3289 = 0.0;
                    float node_3883 = 2.0;
                    float4 node_2531 = _Time;
                    float node_5613 = (node_2531.a*_Strength);
                    float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                    float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                    float2 node_4219 = (v.texcoord0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                    float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                    float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                    float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                    float node_5811 = 1.0;
                    return ((lerp((node_6208_if_leA*node_2680)+(node_6208_if_leB*node_3289),node_2680,node_6208_if_leA*node_6208_if_leB)*node_1347)+node_5811);
                }
                float4 Tessellation(TessVertex v, TessVertex v1, TessVertex v2){
                    float tv = Tessellation(v);
                    float tv1 = Tessellation(v1);
                    float tv2 = Tessellation(v2);
                    return float4( tv1+tv2, tv2+tv, tv+tv1, tv+tv1+tv2 ) / float4(2,2,2,3);
                }
                OutputPatchConstant hullconst (InputPatch<TessVertex,3> v) {
                    OutputPatchConstant o = (OutputPatchConstant)0;
                    float4 ts = Tessellation( v[0], v[1], v[2] );
                    o.edge[0] = ts.x;
                    o.edge[1] = ts.y;
                    o.edge[2] = ts.z;
                    o.inside = ts.w;
                    return o;
                }
                [domain("tri")]
                [partitioning("fractional_odd")]
                [outputtopology("triangle_cw")]
                [patchconstantfunc("hullconst")]
                [outputcontrolpoints(3)]
                TessVertex hull (InputPatch<TessVertex,3> v, uint id : SV_OutputControlPointID) {
                    return v[id];
                }
                [domain("tri")]
                VertexOutput domain (OutputPatchConstant tessFactors, const OutputPatch<TessVertex,3> vi, float3 bary : SV_DomainLocation) {
                    VertexInput v = (VertexInput)0;
                    v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
                    v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
                    v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
                    v.texcoord0 = vi[0].texcoord0*bary.x + vi[1].texcoord0*bary.y + vi[2].texcoord0*bary.z;
                    v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
                    displacement(v);
                    VertexOutput o = vert(v);
                    return o;
                }
            #endif
            float4 frag(VertexOutput i) : COLOR {
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float node_1793 = distance(i.posWorld.rgb,_WorldSpaceCameraPos);
                float node_6133_if_leA = step(node_1793,_Distance);
                float node_6133_if_leB = step(_Distance,node_1793);
                float node_3883 = 2.0;
                float4 node_2531 = _Time;
                float node_5613 = (node_2531.a*_Strength);
                float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                float2 node_4219 = (i.uv0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                float node_6802 = (node_2531.b*_Strength);
                float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                float2 node_2352 = (i.uv0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                float node_6559 = (node_2531.g*_Strength);
                float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                float2 node_1387 = (i.uv0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                float node_8216 = 1.0;
                float3 node_9205 = (node_9066*node_8216);
                float4 _safe_var = tex2D(_safe,TRANSFORM_TEX(i.uv0, _safe));
                float3 node_6133 = lerp((node_6133_if_leA*node_9205)+(node_6133_if_leB*_safe_var.rgb),node_9205,node_6133_if_leA*node_6133_if_leB);
                float3 normalDirection = node_6133;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float node_5423_if_leA = step(node_1793,_Distance);
                float node_5423_if_leB = step(_Distance,node_1793);
                float node_6161 = (node_2531.r*10.0);
                float2 node_9214_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_9214_ty = floor(node_6161 * node_9214_tc_rcp.x);
                float node_9214_tx = node_6161 - node_3883 * node_9214_ty;
                float2 node_9214 = (i.uv0 + float2(node_9214_tx, node_9214_ty)) * node_9214_tc_rcp;
                float2 node_3565_skew = node_9214 + 0.2127+node_9214.x*0.3713*node_9214.y;
                float2 node_3565_rnd = 4.789*sin(489.123*(node_3565_skew));
                float node_3565 = frac(node_3565_rnd.x*node_3565_rnd.y*(1+node_3565_skew.x));
                float node_2883 = (node_3565*2.0+-1.0);
                float node_5811 = 1.0;
                float node_5423 = lerp((node_5423_if_leA*node_2883)+(node_5423_if_leB*node_5811),node_2883,node_5423_if_leA*node_5423_if_leB);
                clip( BinaryDither4x4(node_5423 - 1.5, sceneUVs) );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = 1.0 - node_5423; // Convert roughness to gloss
                float perceptualRoughness = node_5423;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float3 specularAO = node_5423;
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = node_5423;
                float specularMonochrome;
                float3 diffuseColor = node_6133; // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                half surfaceReduction;
                #ifdef UNITY_COLORSPACE_GAMMA
                    surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;
                #else
                    surfaceReduction = 1.0/(roughness*roughness + 1.0);
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular + node_6133) * specularAO;
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                indirectSpecular *= surfaceReduction;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = dot( normalDirection, lightDirection );
                float3 w = node_6133*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = pow(max(float3(0.0,0.0,0.0), NdotLWrap + w ), node_6133);
                float3 backLight = pow(max(float3(0.0,0.0,0.0), -NdotLWrap + w ), node_6133) * node_6133;
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotLWrap);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((forwardLight+backLight) + ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL)) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += node_6133; // Diffuse Ambient Light
                indirectDiffuse += gi.indirect.diffuse;
                indirectDiffuse *= node_5423; // Diffuse AO
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float3 emissive = node_6133;
/// Final Color:

                float node_3071_if_leA = step(node_1793,_Distance);
                float node_3071_if_leB = step(_Distance,node_1793);
                float node_8404 = 0.999;
                float3 finalColor = diffuse * lerp((node_3071_if_leA*node_8404)+(node_3071_if_leB*node_5811),node_8404,node_3071_if_leA*node_3071_if_leB) + specular + emissive;
                fixed4 finalRGBA = fixed4(finalColor,lerp((node_3071_if_leA*node_8404)+(node_3071_if_leB*node_5811),node_8404,node_3071_if_leA*node_3071_if_leB));
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(1,1,1,1));
                return finalRGBA*_Alphamult;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            ZTest Always
            Cull Off
            
            CGPROGRAM
            #pragma hull hull
            #pragma domain domain
            #pragma vertex tessvert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "Tessellation.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 5.0
            // Dithering function, to use with scene UVs (screen pixel coords)
            // 4x4 Bayer matrix, based on https://en.wikipedia.org/wiki/Ordered_dithering
            float BinaryDither4x4( float value, float2 sceneUVs ) {
                float4x4 mtx = float4x4(
                    float4( 1,  9,  3, 11 )/17.0,
                    float4( 13, 5, 15,  7 )/17.0,
                    float4( 4, 12,  2, 10 )/17.0,
                    float4( 16, 8, 14,  6 )/17.0
                );
                float2 px = floor(_ScreenParams.xy * sceneUVs);
                int xSmp = fmod(px.x,4);
                int ySmp = fmod(px.y,4);
                float4 xVec = 1-saturate(abs(float4(0,1,2,3) - xSmp));
                float4 yVec = 1-saturate(abs(float4(0,1,2,3) - ySmp));
                float4 pxMult = float4( dot(mtx[0],yVec), dot(mtx[1],yVec), dot(mtx[2],yVec), dot(mtx[3],yVec) );
                return round(value + dot(pxMult, xVec));
            }
            uniform float _Distance;
			uniform float _Tesssize;
            uniform sampler2D _safe; uniform float4 _safe_ST;
            uniform float _Strength;
			uniform float _Alphamult;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                float4 projPos : TEXCOORD7;
                LIGHTING_COORDS(8,9)
                UNITY_FOG_COORDS(10)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                float node_998_if_leA = step(node_1793,_Distance);
                float node_998_if_leB = step(_Distance,node_1793);
                float node_3832 = _Tesssize;
                float node_3289 = 0.0;
                float node_3883 = 2.0;
                float4 node_2531 = _Time;
                float node_5613 = (node_2531.a*_Strength);
                float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                float2 node_4219 = (o.uv0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                float node_6802 = (node_2531.b*_Strength);
                float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                float2 node_2352 = (o.uv0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                float node_6559 = (node_2531.g*_Strength);
                float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                float2 node_1387 = (o.uv0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                float3 node_956 = (lerp((node_998_if_leA*node_3832)+(node_998_if_leB*node_3289),node_3832,node_998_if_leA*node_998_if_leB)*node_9066);
                v.vertex.xyz += node_956;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            #ifdef UNITY_CAN_COMPILE_TESSELLATION
                struct TessVertex {
                    float4 vertex : INTERNALTESSPOS;
                    float3 normal : NORMAL;
                    float4 tangent : TANGENT;
                    float2 texcoord0 : TEXCOORD0;
                    float2 texcoord1 : TEXCOORD1;
                    float2 texcoord2 : TEXCOORD2;
                };
                struct OutputPatchConstant {
                    float edge[3]         : SV_TessFactor;
                    float inside          : SV_InsideTessFactor;
                    float3 vTangent[4]    : TANGENT;
                    float2 vUV[4]         : TEXCOORD;
                    float3 vTanUCorner[4] : TANUCORNER;
                    float3 vTanVCorner[4] : TANVCORNER;
                    float4 vCWts          : TANWEIGHTS;
                };
                TessVertex tessvert (VertexInput v) {
                    TessVertex o;
                    o.vertex = v.vertex;
                    o.normal = v.normal;
                    o.tangent = v.tangent;
                    o.texcoord0 = v.texcoord0;
                    o.texcoord1 = v.texcoord1;
                    o.texcoord2 = v.texcoord2;
                    return o;
                }
                void displacement (inout VertexInput v){
                    float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                    float node_998_if_leA = step(node_1793,_Distance);
                    float node_998_if_leB = step(_Distance,node_1793);
                    float node_3832 = _Tesssize;
                    float node_3289 = 0.0;
                    float node_3883 = 2.0;
                    float4 node_2531 = _Time;
                    float node_5613 = (node_2531.a*_Strength);
                    float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                    float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                    float2 node_4219 = (v.texcoord0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                    float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                    float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                    float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                    float node_6802 = (node_2531.b*_Strength);
                    float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                    float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                    float2 node_2352 = (v.texcoord0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                    float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                    float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                    float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                    float node_6559 = (node_2531.g*_Strength);
                    float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                    float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                    float2 node_1387 = (v.texcoord0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                    float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                    float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                    float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                    float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                    float3 node_956 = (lerp((node_998_if_leA*node_3832)+(node_998_if_leB*node_3289),node_3832,node_998_if_leA*node_998_if_leB)*node_9066);
                    v.vertex.xyz += node_956;
                }
                float Tessellation(TessVertex v){
                    float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                    float node_6208_if_leA = step(node_1793,_Distance);
                    float node_6208_if_leB = step(_Distance,node_1793);
                    float node_2680 = 1000000.0;
                    float node_3289 = 0.0;
                    float node_3883 = 2.0;
                    float4 node_2531 = _Time;
                    float node_5613 = (node_2531.a*_Strength);
                    float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                    float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                    float2 node_4219 = (v.texcoord0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                    float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                    float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                    float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                    float node_5811 = 1.0;
                    return ((lerp((node_6208_if_leA*node_2680)+(node_6208_if_leB*node_3289),node_2680,node_6208_if_leA*node_6208_if_leB)*node_1347)+node_5811);
                }
                float4 Tessellation(TessVertex v, TessVertex v1, TessVertex v2){
                    float tv = Tessellation(v);
                    float tv1 = Tessellation(v1);
                    float tv2 = Tessellation(v2);
                    return float4( tv1+tv2, tv2+tv, tv+tv1, tv+tv1+tv2 ) / float4(2,2,2,3);
                }
                OutputPatchConstant hullconst (InputPatch<TessVertex,3> v) {
                    OutputPatchConstant o = (OutputPatchConstant)0;
                    float4 ts = Tessellation( v[0], v[1], v[2] );
                    o.edge[0] = ts.x;
                    o.edge[1] = ts.y;
                    o.edge[2] = ts.z;
                    o.inside = ts.w;
                    return o;
                }
                [domain("tri")]
                [partitioning("fractional_odd")]
                [outputtopology("triangle_cw")]
                [patchconstantfunc("hullconst")]
                [outputcontrolpoints(3)]
                TessVertex hull (InputPatch<TessVertex,3> v, uint id : SV_OutputControlPointID) {
                    return v[id];
                }
                [domain("tri")]
                VertexOutput domain (OutputPatchConstant tessFactors, const OutputPatch<TessVertex,3> vi, float3 bary : SV_DomainLocation) {
                    VertexInput v = (VertexInput)0;
                    v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
                    v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
                    v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
                    v.texcoord0 = vi[0].texcoord0*bary.x + vi[1].texcoord0*bary.y + vi[2].texcoord0*bary.z;
                    v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
                    displacement(v);
                    VertexOutput o = vert(v);
                    return o;
                }
            #endif
            float4 frag(VertexOutput i) : COLOR {
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float node_1793 = distance(i.posWorld.rgb,_WorldSpaceCameraPos);
                float node_6133_if_leA = step(node_1793,_Distance);
                float node_6133_if_leB = step(_Distance,node_1793);
                float node_3883 = 2.0;
                float4 node_2531 = _Time;
                float node_5613 = (node_2531.a*_Strength);
                float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                float2 node_4219 = (i.uv0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                float node_6802 = (node_2531.b*_Strength);
                float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                float2 node_2352 = (i.uv0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                float node_6559 = (node_2531.g*_Strength);
                float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                float2 node_1387 = (i.uv0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                float node_8216 = 1.0;
                float3 node_9205 = (node_9066*node_8216);
                float4 _safe_var = tex2D(_safe,TRANSFORM_TEX(i.uv0, _safe));
                float3 node_6133 = lerp((node_6133_if_leA*node_9205)+(node_6133_if_leB*_safe_var.rgb),node_9205,node_6133_if_leA*node_6133_if_leB);
                float3 normalDirection = node_6133;
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                float node_5423_if_leA = step(node_1793,_Distance);
                float node_5423_if_leB = step(_Distance,node_1793);
                float node_6161 = (node_2531.r*10.0);
                float2 node_9214_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_9214_ty = floor(node_6161 * node_9214_tc_rcp.x);
                float node_9214_tx = node_6161 - node_3883 * node_9214_ty;
                float2 node_9214 = (i.uv0 + float2(node_9214_tx, node_9214_ty)) * node_9214_tc_rcp;
                float2 node_3565_skew = node_9214 + 0.2127+node_9214.x*0.3713*node_9214.y;
                float2 node_3565_rnd = 4.789*sin(489.123*(node_3565_skew));
                float node_3565 = frac(node_3565_rnd.x*node_3565_rnd.y*(1+node_3565_skew.x));
                float node_2883 = (node_3565*2.0+-1.0);
                float node_5811 = 1.0;
                float node_5423 = lerp((node_5423_if_leA*node_2883)+(node_5423_if_leB*node_5811),node_2883,node_5423_if_leA*node_5423_if_leB);
                clip( BinaryDither4x4(node_5423 - 1.5, sceneUVs) );
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = 1.0 - node_5423; // Convert roughness to gloss
                float perceptualRoughness = node_5423;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = node_5423;
                float specularMonochrome;
                float3 diffuseColor = node_6133; // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = dot( normalDirection, lightDirection );
                float3 w = node_6133*0.5; // Light wrapping
                float3 NdotLWrap = NdotL * ( 1.0 - w );
                float3 forwardLight = pow(max(float3(0.0,0.0,0.0), NdotLWrap + w ), node_6133);
                float3 backLight = pow(max(float3(0.0,0.0,0.0), -NdotLWrap + w ), node_6133) * node_6133;
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotLWrap);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((forwardLight+backLight) + ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL)) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:

                float node_3071_if_leA = step(node_1793,_Distance);
                float node_3071_if_leB = step(_Distance,node_1793);
                float node_8404 = 0.999;
                float3 finalColor = diffuse * lerp((node_3071_if_leA*node_8404)+(node_3071_if_leB*node_5811),node_8404,node_3071_if_leA*node_3071_if_leB) + specular;
                fixed4 finalRGBA = fixed4(finalColor,0);
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(1,1,1,1));
                return finalRGBA*_Alphamult;
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            Blend One One
            CGPROGRAM
            #pragma hull hull
            #pragma domain domain
            #pragma vertex tessvert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "Tessellation.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 5.0
            // Dithering function, to use with scene UVs (screen pixel coords)
            // 4x4 Bayer matrix, based on https://en.wikipedia.org/wiki/Ordered_dithering
            float BinaryDither4x4( float value, float2 sceneUVs ) {
                float4x4 mtx = float4x4(
                    float4( 1,  9,  3, 11 )/17.0,
                    float4( 13, 5, 15,  7 )/17.0,
                    float4( 4, 12,  2, 10 )/17.0,
                    float4( 16, 8, 14,  6 )/17.0
                );
                float2 px = floor(_ScreenParams.xy * sceneUVs);
                int xSmp = fmod(px.x,4);
                int ySmp = fmod(px.y,4);
                float4 xVec = 1-saturate(abs(float4(0,1,2,3) - xSmp));
                float4 yVec = 1-saturate(abs(float4(0,1,2,3) - ySmp));
                float4 pxMult = float4( dot(mtx[0],yVec), dot(mtx[1],yVec), dot(mtx[2],yVec), dot(mtx[3],yVec) );
                return round(value + dot(pxMult, xVec));
            }
            uniform float _Distance;
			uniform float _Tesssize;
            uniform sampler2D _safe; uniform float4 _safe_ST;
            uniform float _Strength;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float4 projPos : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                float node_998_if_leA = step(node_1793,_Distance);
                float node_998_if_leB = step(_Distance,node_1793);
                float node_3832 = _Tesssize;
                float node_3289 = 0.0;
                float node_3883 = 2.0;
                float4 node_2531 = _Time;
                float node_5613 = (node_2531.a*_Strength);
                float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                float2 node_4219 = (o.uv0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                float node_6802 = (node_2531.b*_Strength);
                float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                float2 node_2352 = (o.uv0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                float node_6559 = (node_2531.g*_Strength);
                float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                float2 node_1387 = (o.uv0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                float3 node_956 = (lerp((node_998_if_leA*node_3832)+(node_998_if_leB*node_3289),node_3832,node_998_if_leA*node_998_if_leB)*node_9066);
                v.vertex.xyz += node_956;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            #ifdef UNITY_CAN_COMPILE_TESSELLATION
                struct TessVertex {
                    float4 vertex : INTERNALTESSPOS;
                    float3 normal : NORMAL;
                    float4 tangent : TANGENT;
                    float2 texcoord0 : TEXCOORD0;
                    float2 texcoord1 : TEXCOORD1;
                    float2 texcoord2 : TEXCOORD2;
                };
                struct OutputPatchConstant {
                    float edge[3]         : SV_TessFactor;
                    float inside          : SV_InsideTessFactor;
                    float3 vTangent[4]    : TANGENT;
                    float2 vUV[4]         : TEXCOORD;
                    float3 vTanUCorner[4] : TANUCORNER;
                    float3 vTanVCorner[4] : TANVCORNER;
                    float4 vCWts          : TANWEIGHTS;
                };
                TessVertex tessvert (VertexInput v) {
                    TessVertex o;
                    o.vertex = v.vertex;
                    o.normal = v.normal;
                    o.tangent = v.tangent;
                    o.texcoord0 = v.texcoord0;
                    o.texcoord1 = v.texcoord1;
                    o.texcoord2 = v.texcoord2;
                    return o;
                }
                void displacement (inout VertexInput v){
                    float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                    float node_998_if_leA = step(node_1793,_Distance);
                    float node_998_if_leB = step(_Distance,node_1793);
                    float node_3832 = _Tesssize;
                    float node_3289 = 0.0;
                    float node_3883 = 2.0;
                    float4 node_2531 = _Time;
                    float node_5613 = (node_2531.a*_Strength);
                    float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                    float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                    float2 node_4219 = (v.texcoord0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                    float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                    float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                    float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                    float node_6802 = (node_2531.b*_Strength);
                    float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                    float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                    float2 node_2352 = (v.texcoord0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                    float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                    float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                    float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                    float node_6559 = (node_2531.g*_Strength);
                    float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                    float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                    float2 node_1387 = (v.texcoord0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                    float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                    float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                    float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                    float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                    float3 node_956 = (lerp((node_998_if_leA*node_3832)+(node_998_if_leB*node_3289),node_3832,node_998_if_leA*node_998_if_leB)*node_9066);
                    v.vertex.xyz += node_956;
                }
                float Tessellation(TessVertex v){
                    float node_1793 = distance(mul(unity_ObjectToWorld, v.vertex).rgb,_WorldSpaceCameraPos);
                    float node_6208_if_leA = step(node_1793,_Distance);
                    float node_6208_if_leB = step(_Distance,node_1793);
                    float node_2680 = 1000000.0;
                    float node_3289 = 0.0;
                    float node_3883 = 2.0;
                    float4 node_2531 = _Time;
                    float node_5613 = (node_2531.a*_Strength);
                    float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                    float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                    float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                    float2 node_4219 = (v.texcoord0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                    float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                    float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                    float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                    float node_5811 = 1.0;
                    return ((lerp((node_6208_if_leA*node_2680)+(node_6208_if_leB*node_3289),node_2680,node_6208_if_leA*node_6208_if_leB)*node_1347)+node_5811);
                }
                float4 Tessellation(TessVertex v, TessVertex v1, TessVertex v2){
                    float tv = Tessellation(v);
                    float tv1 = Tessellation(v1);
                    float tv2 = Tessellation(v2);
                    return float4( tv1+tv2, tv2+tv, tv+tv1, tv+tv1+tv2 ) / float4(2,2,2,3);
                }
                OutputPatchConstant hullconst (InputPatch<TessVertex,3> v) {
                    OutputPatchConstant o = (OutputPatchConstant)0;
                    float4 ts = Tessellation( v[0], v[1], v[2] );
                    o.edge[0] = ts.x;
                    o.edge[1] = ts.y;
                    o.edge[2] = ts.z;
                    o.inside = ts.w;
                    return o;
                }
                [domain("tri")]
                [partitioning("fractional_odd")]
                [outputtopology("triangle_cw")]
                [patchconstantfunc("hullconst")]
                [outputcontrolpoints(3)]
                TessVertex hull (InputPatch<TessVertex,3> v, uint id : SV_OutputControlPointID) {
                    return v[id];
                }
                [domain("tri")]
                VertexOutput domain (OutputPatchConstant tessFactors, const OutputPatch<TessVertex,3> vi, float3 bary : SV_DomainLocation) {
                    VertexInput v = (VertexInput)0;
                    v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
                    v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
                    v.tangent = vi[0].tangent*bary.x + vi[1].tangent*bary.y + vi[2].tangent*bary.z;
                    v.texcoord0 = vi[0].texcoord0*bary.x + vi[1].texcoord0*bary.y + vi[2].texcoord0*bary.z;
                    v.texcoord1 = vi[0].texcoord1*bary.x + vi[1].texcoord1*bary.y + vi[2].texcoord1*bary.z;
                    displacement(v);
                    VertexOutput o = vert(v);
                    return o;
                }
            #endif
            float4 frag(VertexOutput i) : SV_Target {
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w);
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                float node_1793 = distance(i.posWorld.rgb,_WorldSpaceCameraPos);
                float node_6133_if_leA = step(node_1793,_Distance);
                float node_6133_if_leB = step(_Distance,node_1793);
                float node_3883 = 2.0;
                float4 node_2531 = _Time;
                float node_5613 = (node_2531.a*_Strength);
                float2 node_4219_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_4219_ty = floor(node_5613 * node_4219_tc_rcp.x);
                float node_4219_tx = node_5613 - node_3883 * node_4219_ty;
                float2 node_4219 = (i.uv0 + float2(node_4219_tx, node_4219_ty)) * node_4219_tc_rcp;
                float2 node_1347_skew = node_4219 + 0.2127+node_4219.x*0.3713*node_4219.y;
                float2 node_1347_rnd = 4.789*sin(489.123*(node_1347_skew));
                float node_1347 = frac(node_1347_rnd.x*node_1347_rnd.y*(1+node_1347_skew.x));
                float node_6802 = (node_2531.b*_Strength);
                float2 node_2352_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_2352_ty = floor(node_6802 * node_2352_tc_rcp.x);
                float node_2352_tx = node_6802 - node_3883 * node_2352_ty;
                float2 node_2352 = (i.uv0 + float2(node_2352_tx, node_2352_ty)) * node_2352_tc_rcp;
                float2 node_3633_skew = node_2352 + 0.2127+node_2352.x*0.3713*node_2352.y;
                float2 node_3633_rnd = 4.789*sin(489.123*(node_3633_skew));
                float node_3633 = frac(node_3633_rnd.x*node_3633_rnd.y*(1+node_3633_skew.x));
                float node_6559 = (node_2531.g*_Strength);
                float2 node_1387_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_1387_ty = floor(node_6559 * node_1387_tc_rcp.x);
                float node_1387_tx = node_6559 - node_3883 * node_1387_ty;
                float2 node_1387 = (i.uv0 + float2(node_1387_tx, node_1387_ty)) * node_1387_tc_rcp;
                float2 node_3550_skew = node_1387 + 0.2127+node_1387.x*0.3713*node_1387.y;
                float2 node_3550_rnd = 4.789*sin(489.123*(node_3550_skew));
                float node_3550 = frac(node_3550_rnd.x*node_3550_rnd.y*(1+node_3550_skew.x));
                float3 node_9066 = (float3(node_1347,node_3633,node_3550)*2.0+-1.0);
                float node_8216 = 1.0;
                float3 node_9205 = (node_9066*node_8216);
                float4 _safe_var = tex2D(_safe,TRANSFORM_TEX(i.uv0, _safe));
                float3 node_6133 = lerp((node_6133_if_leA*node_9205)+(node_6133_if_leB*_safe_var.rgb),node_9205,node_6133_if_leA*node_6133_if_leB);
                o.Emission = node_6133;
                
                float3 diffColor = node_6133;
                float specularMonochrome;
                float3 specColor;
                float node_5423_if_leA = step(node_1793,_Distance);
                float node_5423_if_leB = step(_Distance,node_1793);
                float node_6161 = (node_2531.r*10.0);
                float2 node_9214_tc_rcp = float2(1.0,1.0)/float2( node_3883, node_3883 );
                float node_9214_ty = floor(node_6161 * node_9214_tc_rcp.x);
                float node_9214_tx = node_6161 - node_3883 * node_9214_ty;
                float2 node_9214 = (i.uv0 + float2(node_9214_tx, node_9214_ty)) * node_9214_tc_rcp;
                float2 node_3565_skew = node_9214 + 0.2127+node_9214.x*0.3713*node_9214.y;
                float2 node_3565_rnd = 4.789*sin(489.123*(node_3565_skew));
                float node_3565 = frac(node_3565_rnd.x*node_3565_rnd.y*(1+node_3565_skew.x));
                float node_2883 = (node_3565*2.0+-1.0);
                float node_5811 = 1.0;
                float node_5423 = lerp((node_5423_if_leA*node_2883)+(node_5423_if_leB*node_5811),node_2883,node_5423_if_leA*node_5423_if_leB);
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, node_5423, specColor, specularMonochrome );
                float roughness = node_5423;
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }

}
