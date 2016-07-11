Shader "Tommy7/1_ripples"
{
	Properties
	{
        _MainTex("Texture", 2D) = "white" {}
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
                float4 newPos = float4(v.vertex.x, v.vertex.y + sin(_Time.y * 3 + v.uv.x * 16) * 0.4, v.vertex.z, v.vertex.w);
				o.vertex = mul(UNITY_MATRIX_MVP, newPos);
                o.uv = v.uv;
				return o;
			}
			
            sampler2D _MainTex;

			float4 frag (v2f i) : SV_Target
			{
                
                //float4 color = float4(i.uv.x, 0,0,1);
                float4 color = tex2D(_MainTex, i.uv);
				return color;
			}
			ENDCG
		}
	}
}
