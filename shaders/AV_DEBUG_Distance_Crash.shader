// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Made and published by AlexViktor#1715
Shader "AV/DEBUG/Distance Crash"
{
	Properties
	{
		_Distance("Distance", Range( 0 , 2)) = 1
		_Iterations("Iterations (x10⁶)", Range( 1 , 1000)) = 1
		[Toggle]_SafeMode("Safe Mode", Int) = 1
		[HideInInspector]_MainTex("MainTex", 2D) = "white" {}
		[HideInInspector]_MaskClipValue("Mask Clip Value", Range( 0 , 1)) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float _MaskClipValue;
		uniform int _SafeMode;
		uniform float _Distance;
		uniform float _Iterations;
		uniform sampler2D _MainTex;


		half3 IterationLoop65( int safeMode , half distance , int iterations , half2 texcoord , half3 normal , sampler2D _texture )
		{
			float3 vertexOffset = (float3)0;
			if (safeMode == 0 && distance == 0)
			{
				for (int i = 0; i < iterations * 1000000; i++)
				{
					float d = tex2Dlod(_texture, float4(texcoord.xy, 0, 0)).r;
					vertexOffset += normal * d;
				}
			}
			return vertexOffset;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			int safeMode65 = _SafeMode;
			float4 transform31 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float temp_output_36_0 = saturate( floor( ( length( ( _WorldSpaceCameraPos - (transform31).xyz ) ) / _Distance ) ) );
			half distance65 = temp_output_36_0;
			int iterations65 = (int)_Iterations;
			half2 texcoord65 = float2( 0,0 );
			float3 ase_vertexNormal = v.normal.xyz;
			half3 normal65 = ase_vertexNormal;
			sampler2D _texture65 = _MainTex;
			half3 localIterationLoop65 = IterationLoop65( safeMode65 , distance65 , iterations65 , texcoord65 , normal65 , _texture65 );
			v.vertex.xyz += localIterationLoop65;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 appendResult10 = (float3(1.0 , 0.0 , 0.0));
			float3 appendResult8 = (float3(0.0 , 1.0 , 0.0));
			float4 transform31 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float temp_output_36_0 = saturate( floor( ( length( ( _WorldSpaceCameraPos - (transform31).xyz ) ) / _Distance ) ) );
			float3 lerpResult34 = lerp( appendResult10 , appendResult8 , temp_output_36_0);
			o.Emission = ( lerpResult34 * _SafeMode );
			o.Alpha = 1;
			int temp_output_21_0 = _SafeMode;
			clip( (float)temp_output_21_0 - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17600
0;695;1856;665;2723.497;330.1168;1.726185;True;False
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;31;-1722.027,114.4494;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;32;-1516.429,109.4494;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;3;-1572.775,-33.2915;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;-1254.317,91.47298;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LengthOpNode;33;-1101.259,92.36803;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-1253.806,190.7416;Inherit;False;Property;_Distance;Distance;0;0;Create;True;0;0;False;0;1;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;47;-963.3456,92.29437;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;43;-828.7072,91.94164;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-693.9324,-142.1833;Inherit;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-691.6323,-24.58334;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;36;-694.9803,92.32808;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-648.2565,245.1426;Inherit;False;Property;_Iterations;Iterations (x10⁶);1;0;Create;False;0;0;False;0;1;1;1;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;58;-562.6245,322.1226;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;21;-534.5928,166.4546;Inherit;False;Property;_SafeMode;Safe Mode;2;0;Create;True;0;0;False;1;Toggle;1;0;0;1;INT;0
Node;AmplifyShaderEditor.TexturePropertyNode;57;-595.8423,463.6797;Inherit;True;Property;_MainTex;MainTex;3;1;[HideInInspector];Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.LerpOp;34;-532.3377,45.59685;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;76;0,-80;Inherit;False;Property;_MaskClipValue;Mask Clip Value;4;1;[HideInInspector];Create;True;0;0;True;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-180.2312,46.59683;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;INT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;65;-232.4505,251.8327;Half;False;float3 vertexOffset = (float3)0@$if (safeMode == 0 && distance == 0)${$	for (int i = 0@ i < iterations * 1000000@ i++)$	{$		float d = tex2Dlod(_texture, float4(texcoord.xy, 0, 0)).r@$		vertexOffset += normal * d@$	}$}$return vertexOffset@;3;False;6;True;safeMode;INT;1;In;;Float;False;True;distance;FLOAT;0;In;;Float;False;True;iterations;INT;0;In;;Float;False;True;texcoord;FLOAT2;0,0;In;;Float;False;True;normal;FLOAT3;0,0,0;In;;Float;False;True;_texture;SAMPLER2D;;In;;Float;False;Iteration Loop;True;False;0;6;0;INT;1;False;1;FLOAT;0;False;2;INT;0;False;3;FLOAT2;0,0;False;4;FLOAT3;0,0,0;False;5;SAMPLER2D;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;AV/DEBUG/Distance Crash;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;76;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;31;0
WireConnection;25;0;3;0
WireConnection;25;1;32;0
WireConnection;33;0;25;0
WireConnection;47;0;33;0
WireConnection;47;1;45;0
WireConnection;43;0;47;0
WireConnection;36;0;43;0
WireConnection;34;0;10;0
WireConnection;34;1;8;0
WireConnection;34;2;36;0
WireConnection;75;0;34;0
WireConnection;75;1;21;0
WireConnection;65;0;21;0
WireConnection;65;1;36;0
WireConnection;65;2;49;0
WireConnection;65;4;58;0
WireConnection;65;5;57;0
WireConnection;0;2;75;0
WireConnection;0;10;21;0
WireConnection;0;11;65;0
ASEEND*/
//CHKSM=F3D758E828215B7774FD6D2DFE1A4C2B6D107751