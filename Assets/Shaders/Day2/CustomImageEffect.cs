using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class CustomImageEffect : MonoBehaviour {

	public Material EffectMaterial;
	
	private void OnRenderImage(RenderTexture src, RenderTexture dest) {
		Graphics.Blit(src, dest, EffectMaterial);
	}
}
