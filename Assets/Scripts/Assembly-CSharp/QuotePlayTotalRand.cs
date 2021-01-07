using System;
using UnityEngine;

// Token: 0x0200005B RID: 91
public class QuotePlayTotalRand : MonoBehaviour
{
	// Token: 0x060001B7 RID: 439 RVA: 0x0000A028 File Offset: 0x00008228
	private void Start() {
		this.md = base.GetComponent<AudioSource>().minDistance;
		this.sPlay = true;
		this.checkone = false;
		this.checktwo = false;
		this.checkthree = false;
		this.order = UnityEngine.Random.Range(1, 4);
		if (this.order == 1) {
			this.checkone = true;
		} else if (this.order == 2) {
			this.checktwo = true;
		} else if (this.order == 3) {
			this.checkthree = true;
		}
	}

	// Token: 0x060001B8 RID: 440 RVA: 0x0000A0B4 File Offset: 0x000082B4
	private void Update() {
		float distance = Vector3.Distance(OVRPlayerController.Instance.transform.position, base.transform.position);
		if (distance < this.md && this.sPlay && this.checkthree) {
			base.GetComponent<AudioSource>().clip = this.first;
			base.GetComponent<AudioSource>().Play();
			this.sPlay = false;
			this.checkthree = false;
			this.checktwo = false;
			this.checkone = true;
		} else if (distance < this.md && this.sPlay && this.checkone) {
			base.GetComponent<AudioSource>().clip = this.second;
			base.GetComponent<AudioSource>().Play();
			this.sPlay = false;
			this.checkthree = false;
			this.checkone = false;
			this.checktwo = true;
		} else if (distance < this.md && this.sPlay && this.checktwo) {
			base.GetComponent<AudioSource>().clip = this.third;
			base.GetComponent<AudioSource>().Play();
			this.sPlay = false;
			this.checkone = false;
			this.checktwo = false;
			this.checkthree = true;
		} else if (distance > 30f && !this.sPlay && !base.GetComponent<AudioSource>().isPlaying) {
			this.sPlay = true;
		}
	}

	// Token: 0x04000297 RID: 663
	private float md;

	// Token: 0x04000298 RID: 664
	private bool sPlay;

	// Token: 0x04000299 RID: 665
	public AudioClip first;

	// Token: 0x0400029A RID: 666
	public AudioClip second;

	// Token: 0x0400029B RID: 667
	public AudioClip third;

	// Token: 0x0400029C RID: 668
	private bool checkone;

	// Token: 0x0400029D RID: 669
	private bool checktwo;

	// Token: 0x0400029E RID: 670
	private bool checkthree;

	// Token: 0x0400029F RID: 671
	public int order;
}
