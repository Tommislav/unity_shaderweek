Shader "Tommy3/Shader1_diffuseColor" {
    SubShader{
        Tags{ "RenderType" = "Opaque" }
        
        CGPROGRAM

        #pragma surface surf Lambert
        struct Input {
            float4 color : COLOR;
        };
        void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = 1; // 1 = (1,1,1,1) = white
        }
        ENDCG
    }
    Fallback "Diffuse"
}