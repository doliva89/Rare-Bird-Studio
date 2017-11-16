using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerSFX : MonoBehaviour {

    public AudioClip grindClip;
    public AudioClip slideClip;

    private PlayerMovement player;

    private AudioSource source;

	// Use this for initialization
	void Start () {
        player = GetComponent<PlayerMovement>();
        source = GetComponent<AudioSource>();
        source.playOnAwake = false;
	}
	
	// Update is called once per frame
	void Update () {

        if (player.sliding && Input.GetButtonDown("Slide") && player.speed > 0.120)
        {
            PlaySlide();
        }
        
        if(!player.sliding || player.speed < 0.124)
        {
            source.Stop();
        }

	}

    void PlaySlide()
    {
        source.clip = slideClip;
        source.Play();
    }
}
