Shader "Stencil/Panorama/Surface"
{
    Properties {
		_MainTex ("Mask (RGB)", 2D) = "white" {}
        _CutOff ("CutOff", Float) = 0
	}
    SubShader {
        Tags { "RenderType"="Opaque" "Queue"="Transparent+50"}


        Pass {
            Stencil {
                Ref 2
                Comp always
                Pass replace
                ZFail replace // we want to write to stencil buffer no matter what z-value is present
            }
            //ColorMask 0 // do not render to any collor
            ZWrite off // do not write z
            //Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            half _CutOff;

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            v2f vert(appdata v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            half4 frag(v2f i) : SV_Target {
                clip(tex2D(_MainTex, i.uv).r - 0.5 + _CutOff);
                return half4(1,0,0,1);
            }
            ENDCG
        }
        
    } 
}