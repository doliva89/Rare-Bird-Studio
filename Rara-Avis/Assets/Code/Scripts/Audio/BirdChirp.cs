using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BirdChirp : MonoBehaviour {

    public AudioClip[] birdChirps;

    public float soundPitchMin = 0.7f;
    public float soundPitchMax = 0.1f;

    public float soundVolumeMin = 0.1f;
    public float soundVolumeMax = 0.3f;

    public float waitTimeMin = 5f;
    public float waitTimeMax = 10f;

    private PauseMenu pauseAudio;

    private AudioSource source;

    void Awake()
    {
        source = GetComponent<AudioSource>();
        pauseAudio = FindObjectOfType<PauseMenu>();
    }

    void Update()
    {
        if(!source.isPlaying && !pauseAudio.pauseMenu)
        {
            playChirps();
        }
        if(pauseAudio.pauseMenu)
        {
            source.Pause();
        }
    }

    void playChirps()
    {
        source.pitch = Random.Range(soundPitchMin, soundPitchMax);
        source.volume = Random.Range(soundVolumeMin, soundVolumeMax);

        int randomChirp = Random.Range(0, birdChirps.Length - 1);
        source.clip = birdChirps[randomChirp];

        source.PlayDelayed(Random.Range(waitTimeMin, waitTimeMax));
    }
}
