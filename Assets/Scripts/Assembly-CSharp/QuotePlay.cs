using System;
using UnityEngine;

// Token: 0x02000059 RID: 89
public class QuotePlay : MonoBehaviour
{
	// Token: 0x060001B0 RID: 432 RVA: 0x00009C10 File Offset: 0x00007E10
	private void Start() {
		this.md = base.GetComponent<AudioSource>().minDistance;
		this.mad = base.GetComponent<AudioSource>().maxDistance;
		this.sPlay = true;
	}

	// Token: 0x060001B1 RID: 433 RVA: 0x00009C48 File Offset: 0x00007E48
	private void Update() {
		if (Vector3.Distance(OVRPlayerController.Instance.transform.position, base.transform.position) < this.md && this.sPlay) {
			base.GetComponent<AudioSource>().Play();
			this.sPlay = false;
		} else if (Vector3.Distance(OVRPlayerController.Instance.transform.position, base.transform.position) > this.mad + this.md && !this.sPlay && !base.GetComponent<AudioSource>().isPlaying) {
			this.sPlay = true;
		}
	}

	// Token: 0x04000289 RID: 649
	private float md;

	// Token: 0x0400028A RID: 650
	private float mad;

	// Token: 0x0400028B RID: 651
	private bool sPlay;
}
