using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerSound : MonoBehaviour {

    public AudioClip[] clip;

    public float soundPitchMin = 1.0f;
    public float soundPitchMax = 0.7f;

    public float soundVolumeMin = 0.1f;
    public float soundVolumeMax = 0.3f;

    private AudioSource source;
	// Use this for initialization
	void Awake () {
        source = GetComponent<AudioSource>();
	}
	
    

	void OnTriggerEnter(Collider col)
    {
        PlayClip();
    }



    void PlayClip()
    {
        source.pitch = Random.Range(soundPitchMin, soundPitchMax);
        source.volume = Random.Range(soundVolumeMin, soundVolumeMax);

        int randomClip = Random.Range(0, clip.Length - 1);

        source.PlayOneShot(clip[randomClip], 0.1F);
    }
}
