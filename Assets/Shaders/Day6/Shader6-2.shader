Shader "Tommy6/2_smoke"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Radius("Radius", Float) = 0.5
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
            #pragma enable_d3d11_debug_symbols
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
                float2 worldPos : TEXCOORD1;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = v.uv;
                o.worldPos = mul(_Object2World, v.vertex).xyz;
                return o;
            }

            sampler2D _MainTex;
            float _Radius;
            uniform float2 _MousePos;



            float4 frag(v2f i) : SV_Target
            {
                float d = distance(_MousePos, i.worldPos);
                float dN = 1 - saturate(d / _Radius);

                float4 color = tex2D(_MainTex, i.uv) * 0.9 + dN * float4(1, 1, 1, 1);
                return color;
            }
            ENDCG
        }
    }
}
