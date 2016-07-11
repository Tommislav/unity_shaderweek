Shader "Tommy3/Shader3_textureWorldpos" {

    Properties{
        _MainTex ("Texture", 2D) = "white" {}
        _Center("Center", Vector) = (0,0,0,0)
        _Radius("Radius", Float) = 0.5
    }

    SubShader{
        Tags{ "RenderType" = "Opaque" }
        
        CGPROGRAM

        #pragma surface surf Lambert
        struct Input {
          float2 uv_MainTex;
          float3 worldPos;
      };

      sampler2D _MainTex;
      float3 _Center;
      float _Radius;


      void surf (Input IN, inout SurfaceOutput o) {
          // Note: if-statements (branching) are very ineffective on gpu. Try to avoid.
          // there are lots of clever functions to avoid this.

          /*
          float d = distance(_Center, IN.worldPos);
          float dN = 1 - saturate(d / _Radius);

          if (dN > 0.03 && dN < 0.07)
              o.Albedo = half3(1, 1, 1);
          else
              o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
          */

        float d = distance(_Center, IN.worldPos);
        float dN = 1 - saturate(d / _Radius);
        dN = step(0.03, dN) * step(dN, 0.07);
        o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * (1 - dN) + half3(1, 1, 1) * dN;

      }
      ENDCG
    } 
    Fallback "Diffuse"
}