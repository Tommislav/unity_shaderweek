using UnityEngine;
using System.Collections;

public class MousePosToShader : MonoBehaviour {

	public Material material;

	private void Update () {
		Vector3 mouse = Input.mousePosition;
		mouse.z = transform.position.z;
		material.SetVector("_MousePos",
			Camera.main.ScreenToWorldPoint(mouse)
		);
	}
}
