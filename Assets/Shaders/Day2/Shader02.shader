Shader "Tommy2/Shader02"
{
	
    Properties{
        _MainTex("Texture", 2D) = "white" {}
        _Displace ("Texture", 2D) = "white" {}
        _Magnitude("Magnitude", Range(0,1)) = 0.5
    }

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
                float4 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
                float4 uv : TEXCOORD0;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = v.uv;
				return o;
			}
			
            sampler2D _MainTex;
            sampler2D _Displace;
            float _Magnitude;

			float4 frag (v2f i) : SV_Target
			{
                float2 disp = tex2D(_Displace, i.uv).xy;
                disp = -((disp * 2) - 1) * _Magnitude;
                //disp = -((disp * 2) - 1) * _Magnitude * _Time.x;

                float4 col = tex2D(_MainTex, i.uv + disp);
                //col *= float4(i.uv.x, i.uv.y, 0, 1);
				return col;
			}
			ENDCG
		}
	}
}
