using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class MenuSound : MonoBehaviour {


    public AudioClip buttonHighlight;
    public AudioClip buttonPressed;
    public float highlightButtonVolume = 0.5f;
    public float buttonPressedVolume = 0.5f;

    private AudioSource source;

    // Use this for initialization
    void Start () {
        source = GetComponent<AudioSource>();
        source.playOnAwake = false;
	}
	
	public void ButtonHighlight()
    {
        source.PlayOneShot(buttonHighlight, highlightButtonVolume);
    }

    public void ButtonPressed()
    {
        source.PlayOneShot(buttonPressed, buttonPressedVolume);
    }

}
