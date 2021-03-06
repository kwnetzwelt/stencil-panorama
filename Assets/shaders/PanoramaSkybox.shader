﻿Shader "Stencil/Panorama/Skybox" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue"="Transparent+52"}
		Pass {
			Stencil {
				Ref 2 // we want tis to render only to pixels where 2 is stored
				Comp Equal
			}
			
			ZTest always
            ZWrite on // write z to "max" distance in panorama
            
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma shader_feature stencil_panorama
			float4 _Color;
			struct appdata {
                float4 vertex : POSITION;
            };
            struct v2f {
                float4 pos : SV_POSITION;
            };
            v2f vert(appdata v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            half4 frag(v2f i) : SV_Target {
                return _Color;
            }
            ENDCG
		}
	}


	FallBack "Diffuse"
}
