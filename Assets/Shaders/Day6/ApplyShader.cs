using UnityEngine;
using System.Collections;

public class ApplyShader : MonoBehaviour {


	public Material material; // Wraps the shader

	public RenderTexture texture;
	private RenderTexture buffer;

	public Texture initialTexture;


	private float lastUpdateTime = 0;
	public float updateInterval = 0.1f; // Seconds



	public void UpdateTexture() {
		Graphics.Blit(texture, buffer, material); // texture is source, buffer is destination. Material holds the shader that modifies output
		Graphics.Blit(buffer, texture); // blit buffer back to the texture - texture needs to be a shared resource rendered by someone else
	}
	
	private void Start() {
		Graphics.Blit(initialTexture, texture);

		buffer = new RenderTexture(texture.width, texture.height, texture.depth, texture.format);
	}
	
	private void Update() {
		if(Time.time > lastUpdateTime + updateInterval) {
			UpdateTexture();
			lastUpdateTime = Time.time;
		}
	}
}
