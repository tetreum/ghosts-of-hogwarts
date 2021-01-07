using System;
using UnityEngine;

// Token: 0x02000009 RID: 9
public class DoorRotation : MonoBehaviour
{
	// Token: 0x06000017 RID: 23 RVA: 0x00002AC8 File Offset: 0x00000CC8
	private void Start() {
		this.md = base.GetComponent<AudioSource>().minDistance;
		if (!this.inversement) {
			this.ouverture = 90f;
			this.ouvRot = 90f;
		} else if (this.inversement) {
			this.ouverture = 270f;
			this.ouvRot = -90f;
		}
	}

	// Token: 0x06000018 RID: 24 RVA: 0x00002B30 File Offset: 0x00000D30
	private void Update() {
		if (this.rotation.eulerAngles.z == 0f) {
			this.open = false;
		}
		if (this.rotation.eulerAngles.z >= this.ouverture) {
			this.open = true;
		}
		if (Vector3.Distance(GameObject.Find("OVRPlayerController").transform.position, base.transform.position) < this.md && !this.open) {
			if (base.transform.localRotation.eulerAngles.z <= 0f) {
				base.GetComponent<AudioSource>().clip = this.first;
				base.GetComponent<AudioSource>().Play();
			}
			this.ouvrir = true;
		} else if (Vector3.Distance(GameObject.Find("OVRPlayerController").transform.position, base.transform.position) >= this.md && this.open) {
			if (!this.inversement && base.transform.localRotation.eulerAngles.z >= this.ouverture) {
				base.GetComponent<AudioSource>().clip = this.second;
				base.GetComponent<AudioSource>().Play();
			}
			if (this.inversement && base.transform.localRotation.eulerAngles.z <= this.ouverture) {
				base.GetComponent<AudioSource>().clip = this.second;
				base.GetComponent<AudioSource>().Play();
			}
			this.ouvrir = false;
		}
		if (this.ouvrir) {
			if (this.tParam <= 1f) {
				this.tParam += Time.deltaTime * 0.3f;
			}
			this.rotation.eulerAngles = new Vector3(base.transform.localRotation.x, base.transform.localRotation.y, Mathf.SmoothStep(0f, this.ouvRot, this.tParam));
			base.transform.localRotation = this.rotation;
		} else if (!this.ouvrir) {
			if (this.tParam >= 0f) {
				this.tParam -= Time.deltaTime * 0.3f;
			}
			this.rotation.eulerAngles = new Vector3(base.transform.localRotation.x, base.transform.localRotation.y, Mathf.SmoothStep(0f, this.ouvRot, this.tParam));
			base.transform.localRotation = this.rotation;
		}
	}

	// Token: 0x0400002E RID: 46
	private float tParam;

	// Token: 0x0400002F RID: 47
	private float md;

	// Token: 0x04000030 RID: 48
	private bool sPlay;

	// Token: 0x04000031 RID: 49
	public AudioClip first;

	// Token: 0x04000032 RID: 50
	public AudioClip second;

	// Token: 0x04000033 RID: 51
	private bool open;

	// Token: 0x04000034 RID: 52
	private bool ouvrir;

	// Token: 0x04000035 RID: 53
	private Quaternion rotation;

	// Token: 0x04000036 RID: 54
	public bool inversement;

	// Token: 0x04000037 RID: 55
	private float ouverture;

	// Token: 0x04000038 RID: 56
	private float ouvRot;
}
