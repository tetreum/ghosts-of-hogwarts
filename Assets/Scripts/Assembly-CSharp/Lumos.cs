using System;
using UnityEngine;

// Token: 0x0200000F RID: 15
public class Lumos : MonoBehaviour
{
	// Token: 0x06000028 RID: 40 RVA: 0x000032D8 File Offset: 0x000014D8
	private void Start() {
		if (QualitySettings.GetQualityLevel() <= 2) {
			base.GetComponent<Light>().bounceIntensity = 0f;
		}
	}

	// Token: 0x06000029 RID: 41 RVA: 0x000032F8 File Offset: 0x000014F8
	private void Update() {
		if (Input.GetKeyDown(KeyCode.Mouse1)) {
			if (base.GetComponent<Light>().intensity == 0f) {
				this.tParam = 0f;
				this.btn = true;
				base.GetComponent<AudioSource>().clip = this.Lumo;
				base.GetComponent<AudioSource>().Play();
			} else if (base.GetComponent<Light>().intensity == 1.65f) {
				this.tParam = 0f;
				base.GetComponent<AudioSource>().clip = this.Nox;
				base.GetComponent<AudioSource>().Play();
				this.btn = false;
			}
		}
		if (!this.btn && this.tParam < 1f) {
			this.tParam += Time.deltaTime;
			base.GetComponent<Light>().intensity = Mathf.Lerp(1.65f, 0f, this.tParam);
		} else if (this.btn && this.tParam < 1f) {
			this.tParam += Time.deltaTime;
			base.GetComponent<Light>().intensity = Mathf.Lerp(0f, 1.65f, this.tParam);
		}
	}

	// Token: 0x0400004C RID: 76
	public AudioClip Lumo;

	// Token: 0x0400004D RID: 77
	public AudioClip Nox;

	// Token: 0x0400004E RID: 78
	private bool btn;

	// Token: 0x0400004F RID: 79
	private float tParam;
}
