using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerSound : MonoBehaviour {

    public AudioClip[] clip;

    private AudioSource source;
	// Use this for initialization
	void Awake () {
        source = GetComponent<AudioSource>();
	}
	
    

	void OnTriggerEnter(Collider col)
    {
        source.PlayOneShot(clip[0],0.1F);
    }



    void PlayClip()
    {
        //add random clip
        //add random volume (max,min)
        //add random pitch (max,min)
    }
}
