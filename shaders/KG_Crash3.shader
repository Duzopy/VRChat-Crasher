// Do you know da wae of KG ?
// KG:https://discord.gg/sb62W6D
// BY:andromeda#6969===========JozielBorges#4746
//Token.take {
	//KG.bot.discord
	// Insirt here your discord Token
	//authentication.token {
	//Token: //TOKEN
	//Token.bot: NDx3elhdNfv3Zd5DQjUqoDfU.DB0mMm.iEZHYoIeHUa6I7F6O8wqZVy9Eoz //Changer to you discord bot
	//}

	//authentication.channel {
	//channel_name: #authentication //change here for you authentication channel,dont put numbers
	//}
//}
Shader "Knuckles_Gang/Free Crash" {
Properties {
		[Header(______________________MADE BY KG______________________)]
		[Header(____________________KNUCKLES_GANG________________)]
		[Space(18)]
		[Header(______andromeda6969__________JozielBorges4746______)]
		[Space(18)]
		[Header(_____________________SAFE______________________)]
		[Header(_____________________9)]
		[Header(_____________________RECOMMENDED________________________)]
		[Header(_____________________99)]
		[Header(_____________________RISK________________________)]
		[Header(_____________________999)]
		[Header(_____________________ARE YOU RETARD________________________)]
		[Header(_____________________9999999999999)]

		volsteps("Crash", int) = 1
         }
    SubShader {
		Tags { "RenderType"="TransparentCutout" "Queue"="Overlay+106000" }
		// Queue"="Overlay+6000 to set "RenderQueue" higher. 
		LOD 200
		Lighting On
		Cull Off
		ZTest Always // ZTest Makes the object able to be seen through objects with a lower render queue

        Pass {
            CGPROGRAM
			#pragma exclude_renderers gles
    
            #include "UnityCG.cginc"

            #pragma fragment frag
			#pragma vertex vert
            
			uniform float iterations;
			uniform float formuparam;

			uniform float volsteps;
			uniform float stepsize;

			uniform float zoom;
			uniform float tile;
			uniform float speed; 

			uniform float brightness;
			uniform float darkmatter;
			uniform float distfading;
			uniform float saturation;
			
			uniform float time;
			uniform float2 mouse;
			uniform float2 resolution;		
            
            float4 vert(float4 v:POSITION) : SV_POSITION {
                return UnityObjectToClipPos (v);
            }

            fixed4 frag(float4 sp:VPOS) : COLOR {
            	//return float4(1, 0, 0, 1);
				//get coords and direction
				float2 uv = sp.xy/resolution.xy - 0.5;
				uv.y *= resolution.y/resolution.x;
				float3 dir = float3(uv*zoom, 1.);
				float time = _Time[0] * speed + 0.25;
				
				//mouse rotation
				float a1=.5+mouse.x/resolution.x*2.;
				float a2=.8+mouse.y/resolution.y*2.;
				float2x2 rot1 = float2x2(cos(a1),sin(a1),-sin(a1),cos(a1));
				float2x2 rot2 = float2x2(cos(a2),sin(a2),-sin(a2),cos(a2));
				dir.xz = mul(dir.xz, rot1);
				dir.xy = mul(dir.xy, rot2);
				float3 from = float3(1.0,0.5,0.5);
				from += float3(time*2.,time,-2.);
				from.xz = mul(from.xz, rot1);
				from.xy = mul(from.xy, rot2);
				
				//volumetric rendering
				float s=0.1, fade=1.;
				float3 v = float3(0.0, 0.0, 0.0);
				
				for (int r=0; r<volsteps; r++) {
					float3 p=from+s*dir*.5;
					p = abs(float3(tile,tile,tile) - fmod(p, float3(tile*2.0, tile*2.0, tile*2.0)));
					float pa,a=pa=0.;
					for (int i=0; i<iterations; i++) { 
						p=abs(p)/dot(p,p)-formuparam;
						a+=abs(length(p)-pa);
						pa=length(p);
					}
					float dm=max(0.,darkmatter-a*a*.001);
					a*=a*a;
					if (r>6) fade*=1.-dm;
					v+=fade;
					v+=float3(s,s*s,s*s*s*s)*a*brightness*fade;
					fade*=distfading;
					s+=stepsize;
				}
				v = lerp(float3(length(v), length(v), length(v)), v, saturation);
                return float4(v*0.01, 1.0);
            }		 
		
			ENDCG
		}
	}
}
