using System;
using UnityEngine;

// Token: 0x02000007 RID: 7
public class DisableGO : MonoBehaviour
{
	// Token: 0x06000010 RID: 16 RVA: 0x00002690 File Offset: 0x00000890
	private void Start() {
		this.LibPos = this.Lib.transform.position;
		this.LibS = this.Lib.transform.localScale.x / 2f;
		this.ToiPos = this.Toi.transform.position;
		this.ToiS = this.Toi.transform.localScale.x / 2f;
		this.DivPos = this.Div.transform.position;
		this.DivS = this.Div.transform.localScale.x / 2f;
		this.CorPos = this.Cor.transform.position;
		this.CorS = this.Cor.transform.localScale.x / 2f;
		this.StaPos = this.Sta.transform.position;
		this.StaS = this.Sta.transform.localScale.x / 2f;
		this.GrePos = this.Gre.transform.position;
		this.GreS = this.Gre.transform.localScale.x / 2f;
		this.DorPos = this.Dor.transform.position;
		this.DorS = this.Dor.transform.localScale.x / 2f;
	}

	// Token: 0x06000011 RID: 17 RVA: 0x00002838 File Offset: 0x00000A38
	private void Update() {
		if (Vector3.Distance(base.transform.position, this.LibPos) < this.LibS) {
			this.Library.SetActive(true);
		} else {
			this.Library.SetActive(false);
		}
		if (Vector3.Distance(base.transform.position, this.ToiPos) < this.ToiS) {
			this.Toilets.SetActive(true);
		} else {
			this.Toilets.SetActive(false);
		}
		if (Vector3.Distance(base.transform.position, this.DivPos) < this.DivS) {
			this.Divination.SetActive(true);
		} else {
			this.Divination.SetActive(false);
		}
		if (Vector3.Distance(base.transform.position, this.CorPos) < this.CorS) {
			this.Corridor.SetActive(true);
		} else {
			this.Corridor.SetActive(false);
		}
		if (Vector3.Distance(base.transform.position, this.StaPos) < this.StaS) {
			this.Stairs.SetActive(true);
		} else {
			this.Stairs.SetActive(false);
		}
		if (Vector3.Distance(base.transform.position, this.GrePos) < this.GreS) {
			this.GreatHall.SetActive(true);
		} else {
			this.GreatHall.SetActive(false);
		}
		if (Vector3.Distance(base.transform.position, this.DorPos) < this.DorS) {
			this.Dortoir.SetActive(true);
		} else {
			this.Dortoir.SetActive(false);
		}
	}

	// Token: 0x04000012 RID: 18
	public GameObject Lib;

	// Token: 0x04000013 RID: 19
	public GameObject Toi;

	// Token: 0x04000014 RID: 20
	public GameObject Div;

	// Token: 0x04000015 RID: 21
	public GameObject Cor;

	// Token: 0x04000016 RID: 22
	public GameObject Sta;

	// Token: 0x04000017 RID: 23
	public GameObject Gre;

	// Token: 0x04000018 RID: 24
	public GameObject Dor;

	// Token: 0x04000019 RID: 25
	public GameObject Library;

	// Token: 0x0400001A RID: 26
	public GameObject Toilets;

	// Token: 0x0400001B RID: 27
	public GameObject Divination;

	// Token: 0x0400001C RID: 28
	public GameObject Corridor;

	// Token: 0x0400001D RID: 29
	public GameObject Stairs;

	// Token: 0x0400001E RID: 30
	public GameObject GreatHall;

	// Token: 0x0400001F RID: 31
	public GameObject Dortoir;

	// Token: 0x04000020 RID: 32
	private Vector3 LibPos;

	// Token: 0x04000021 RID: 33
	private Vector3 ToiPos;

	// Token: 0x04000022 RID: 34
	private Vector3 DivPos;

	// Token: 0x04000023 RID: 35
	private Vector3 CorPos;

	// Token: 0x04000024 RID: 36
	private Vector3 StaPos;

	// Token: 0x04000025 RID: 37
	private Vector3 GrePos;

	// Token: 0x04000026 RID: 38
	private Vector3 DorPos;

	// Token: 0x04000027 RID: 39
	private float LibS;

	// Token: 0x04000028 RID: 40
	private float ToiS;

	// Token: 0x04000029 RID: 41
	private float DivS;

	// Token: 0x0400002A RID: 42
	private float CorS;

	// Token: 0x0400002B RID: 43
	private float StaS;

	// Token: 0x0400002C RID: 44
	private float GreS;

	// Token: 0x0400002D RID: 45
	private float DorS;
}
