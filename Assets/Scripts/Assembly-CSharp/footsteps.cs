using System;
using System.Collections;
using UnityEngine;

[RequireComponent(typeof(CharacterController))]
[RequireComponent(typeof(AudioSource))]
public class footsteps : MonoBehaviour
{
	public AudioClip[] soundCarpet;

	public AudioClip[] soundGrass;
	public AudioClip[] soundWood;
	public AudioClip[] soundRock;
	public AudioClip[] soundGravel;
	private CharacterController _controller;

	private void Awake() {
		this._controller = base.GetComponent<CharacterController>();
	}

	private IEnumerator Start() {
		for (; ; )
		{
			float vel = this._controller.velocity.magnitude;
			RaycastHit hit = default(RaycastHit);
			if (this._controller.isGrounded && vel > 0.2f) {
				if (Physics.Raycast(base.transform.position, Vector3.down, out hit)) {
					string floortag = hit.collider.gameObject.tag;
					if (floortag == "carpet") {
						base.GetComponent<AudioSource>().volume = 0.1f;
						base.GetComponent<AudioSource>().clip = this.soundCarpet[UnityEngine.Random.Range(0, this.soundCarpet.Length)];
					} else if (floortag == "grass") {
						base.GetComponent<AudioSource>().volume = 0.1f;
						base.GetComponent<AudioSource>().clip = this.soundGrass[UnityEngine.Random.Range(0, this.soundGrass.Length)];
					} else if (floortag == "wood") {
						base.GetComponent<AudioSource>().volume = 0.1f;
						base.GetComponent<AudioSource>().clip = this.soundWood[UnityEngine.Random.Range(0, this.soundWood.Length)];
					} else if (floortag == "rock") {
						base.GetComponent<AudioSource>().volume = 0.1f;
						base.GetComponent<AudioSource>().clip = this.soundRock[UnityEngine.Random.Range(0, this.soundRock.Length)];
					} else if (floortag == "gravel") {
						base.GetComponent<AudioSource>().volume = 0.1f;
						base.GetComponent<AudioSource>().clip = this.soundGravel[UnityEngine.Random.Range(0, this.soundGravel.Length)];
					}
				}
				base.GetComponent<AudioSource>().PlayOneShot(base.GetComponent<AudioSource>().clip);
				float interval = base.GetComponent<AudioSource>().clip.length;
				yield return new WaitForSeconds(interval);
			} else {
				yield return 0;
			}
		}
		yield break;
	}
	
}
