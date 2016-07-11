Shader "Tommy6/1_simpleInvert"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
    }

    SubShader
    {
        // the two following lines MUST be set for us to be able to update a renderTexture continously
        ZTest Always Cull Off ZWrite Off 
        Fog{ Mode off }

        Tags
        {
            "Queue" = "Transparent"
            "PreviewType" = "Plane"
        }

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;

            float4 frag(v2f i) : SV_Target
            {

                float4 color = tex2D(_MainTex, i.uv);
                color.rgb = 1 - color.rgb;
                return color;
            }
            ENDCG
        }
    }
}
