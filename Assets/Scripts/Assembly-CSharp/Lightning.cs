using System;
using UnityEngine;

// Token: 0x0200000D RID: 13
public class Lightning : MonoBehaviour
{
	// Token: 0x06000022 RID: 34 RVA: 0x00003124 File Offset: 0x00001324
	private void Start() {
		this.ltbase = base.GetComponent<Light>().intensity;
		base.GetComponent<Light>().intensity = 0f;
		if (QualitySettings.GetQualityLevel() == 0) {
			base.enabled = false;
		}
	}

	// Token: 0x06000023 RID: 35 RVA: 0x00003164 File Offset: 0x00001364
	private void Update() {
		if (Time.time - this.lastTime > this.minTime) {
			if (UnityEngine.Random.value > this.thresh) {
				base.GetComponent<Light>().intensity = UnityEngine.Random.Range(0f, this.ltbase);
			} else {
				base.GetComponent<Light>().intensity = 0f;
				this.lastTime = Time.time;
			}
		}
	}

	// Token: 0x04000044 RID: 68
	private float minTime = 4f;

	// Token: 0x04000045 RID: 69
	private float thresh = 0.1f;

	// Token: 0x04000046 RID: 70
	private float ltbase;

	// Token: 0x04000047 RID: 71
	private float lastTime;
}
