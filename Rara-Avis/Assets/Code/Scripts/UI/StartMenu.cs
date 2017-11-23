using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class StartMenu : MonoBehaviour
{

    public GameObject mainMenuObj;
    public GameObject creditsObj;

    public void StartGame()
    {
        SceneManager.LoadScene("main");
    }

    public void CreditsScreen()
    {
        mainMenuObj.SetActive(false);
        creditsObj.SetActive(true);
    }

    public void QuitGame()
    {
        Application.Quit();
    }

    public void MainMenu()
    {
        creditsObj.SetActive(false);
        mainMenuObj.SetActive(true);
    }
}