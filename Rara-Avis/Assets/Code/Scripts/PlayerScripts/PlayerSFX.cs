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
		
        if(player.grind)
        {
            source.clip = grindClip;
            source.Play();
        }
        if(!player.grind)
        {
            source.Stop();
        }

        if(player.sliding)
        {
            source.clip = slideClip;
            source.PlayOneShot(slideClip, 0.5f);
        }
        
        if(!player.sliding)
        {
            source.Stop();
        }

	}
}
