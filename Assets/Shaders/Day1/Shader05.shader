Shader "Tommy1/Shader05"
{
	Properties
	{
        _MainTex("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1,0,0,1)
        _Value("Value", Range(0,1)) = 0.5
	}

	SubShader
	{
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

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = v.uv;
				return o;
			}
			
            sampler2D _MainTex;
            float4 _Color;
            float _Value;

			float4 frag (v2f i) : SV_Target
			{
                
                float4 texCol = tex2D(_MainTex, i.uv * 2);
                float4 color = texCol * _Value + _Color * (1-_Value);
                color.a = texCol.a;
                
				return color;
			}
			ENDCG
		}
	}
}
