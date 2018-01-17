Shader "Stencil/Panorama/Surface"
{
    SubShader {
        Tags { "RenderType"="Opaque" "Queue"="Transparent+50"}
        Pass {
            Stencil {
                Ref 2
                Comp always
                Pass replace
                ZFail replace // we want to write to stencil buffer no matter what z-value is present
            }
            ColorMask 0 // do not render to any collor
            ZWrite off // do not write z
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
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
                return half4(1,0,0,1);
            }
            ENDCG
        }
    } 
}