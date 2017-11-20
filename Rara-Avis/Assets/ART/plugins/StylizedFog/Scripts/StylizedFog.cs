/// <summary>
/// Stylized fog
/// Author: Yan Verde
/// Date: 08/14/15
/// Version: 1.0.4 
///[1.0.4] Revert some experimental code.
///[1.0.3] Add some blending modes. - Add an option to exclude the Skybox. 
///[1.0.2] Fixed memory leak when spamming public function UpdateTextures()
/// </summary>

using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
[AddComponentMenu("Image Effects/Stylized Fog")]
public class StylizedFog : MonoBehaviour {
	
	public enum StylizedFogMode
	{
		Blend,
		Additive,
		Multiply,
		Screen,
		Overlay,
		Dodge
	}

	public enum StylizedFogGradient
	{
		Textures,
		Gradients,
	}
	
	public StylizedFogMode fogMode;
	public bool ExcludeSkybox = false;

	[Header("Blend")]
	[Tooltip("Use a second ramp for transition")]
	[SerializeField]
	private bool useBlend;
	[Tooltip("Amount of blend between 2 gradients")]
	[Range(0f,1f)]
	public float blend = 0.0f;

	[Header("Gradients")]
	[Tooltip("Use ramp from textures or gradient fields")]
	public StylizedFogGradient gradientSource;

	public Gradient rampGradient;
	public Gradient rampBlendGradient;

	public Texture2D rampTexture;
	public Texture2D rampBlendTexture;

	[Header("AdvancedMode")]
	[Tooltip("Experimental: Will remap the depth to custom values. \nUseful when you have big camera range")]
	public bool AdvancedMode;
	public float NearRange = 0f;
	public float FarRange = 1000f;

	[Header("Noise Texture")]
	[SerializeField]
	private bool useNoise;
	public Texture2D noiseTexture;
	[Space(5f)]
	[Tooltip("XY: Speed1 XY | WH: Speed2 XY")]
	public Vector4 noiseSpeed;
	[Space(5f)]
	[Tooltip("XY: Tiling1 XY | WH: Tiling2 XY")]
	public Vector4 noiseTiling = new Vector4(1,1,1,1);




	private Camera cam;
	private Texture2D mainRamp;
	private Texture2D blendRamp;
	private Shader fogShader;
	private Material fogMat;

	void Start () {
		createResources();
		UpdateTextures();
		SetKeywords();
	}

	void OnEnable(){
		createResources();
		UpdateTextures();
		SetKeywords();
	}

	void OnDisable(){
		clearResources();
	}
	
	/// <summary>
	/// Updates the gradient for realTime editing.
	/// </summary>
	public void UpdateTextures()
	{
		setGradient();
		SetKeywords();
		updateValues();
	}

	private void updateValues()
	{
		if(fogMat == null || fogShader == null)
		{
			createResources();
		}

		if(mainRamp != null)
		{
			fogMat.SetTexture("_SF_MainRamp",mainRamp);
		}

		if(useBlend && blendRamp != null)
		{
			fogMat.SetTexture("_SF_BlendRamp",blendRamp);
			fogMat.SetFloat("_SF_Blend",blend);
		}

		if(useNoise && noiseTexture != null)
		{
			fogMat.SetTexture("_SF_NoiseTex",noiseTexture);
			fogMat.SetVector("_SF_NoiseSpeed",noiseSpeed);
			fogMat.SetVector("_SF_NoiseTiling",noiseTiling);
		}

		if (AdvancedMode) 
		{
			fogMat.SetFloat("_SF_Near",NearRange);
			fogMat.SetFloat("_SF_Far",FarRange);
		}
	}

	/// <summary>
	/// Sets the gradients from the inspector or from 2D textures.
	/// </summary>
	private void setGradient(){

		if(gradientSource == StylizedFogGradient.Textures)
		{
			mainRamp = rampTexture;
			if(useBlend)
			{
				blendRamp = rampBlendTexture;
			}
		}else if(gradientSource == StylizedFogGradient.Gradients)
		{
			if(mainRamp != null){DestroyImmediate(mainRamp);}
			mainRamp = GenerateGradient(rampGradient,256,8);
			if(useBlend)
			{
				if(blendRamp != null){DestroyImmediate(blendRamp);}
				blendRamp = GenerateGradient(rampBlendGradient,256,8);
			}
		}
	}
	/// <summary>
	/// Generates a gradient and assign it to a temporary texture2D.
	/// </summary>
	/// <returns>The gradient.</returns>
	/// <param name="gradient">Gradient ramp</param>
	/// <param name="gWidth">ramp width.</param>
	/// <param name="gHeight">ramp height.</param>
	private Texture2D GenerateGradient(Gradient gradient, int gWidth, int gHeight)
	{
		Texture2D newTex = new Texture2D(gWidth, gHeight, TextureFormat.ARGB32, false);
		newTex.wrapMode = TextureWrapMode.Clamp;
		newTex.hideFlags = HideFlags.HideAndDontSave;
		Color current = Color.white;

		if(gradient != null)
		{
			for(int w = 0; w < gWidth; ++w)
			{
				current = gradient.Evaluate (w / (float)gWidth);

				for(int h = 0; h < gHeight; ++h){
					newTex.SetPixel (w, h, current);
				}
			}
		}

		newTex.Apply();

		return newTex;
	}
	/// <summary>
	/// Creates the Shader, Material and ramps for the first time.
	/// </summary>
	private void createResources(){
		//Set Shader
		if(fogShader == null)
		{
			fogShader = Shader.Find("Hidden/StylizedFog");
		}
		//Set Material
		if(fogMat == null && fogShader != null)
		{
			fogMat = new Material(fogShader);
			fogMat.hideFlags = HideFlags.HideAndDontSave;
		}
		//Set Gradients
		if(mainRamp == null || blendRamp == null)
		{
			setGradient();
		}
		//Set Camera and depth texture
		if(cam == null)
		{
			cam = GetComponent<Camera>();
			cam.depthTextureMode |= DepthTextureMode.Depth;
		}
	}

	private void clearResources()
	{
		if(fogMat != null)
		{
			DestroyImmediate(fogMat);
		}

		disableKeywords();
		cam.depthTextureMode = DepthTextureMode.None;
	}

	public void SetKeywords(){

		//Mode
		switch(fogMode)
		{
			case StylizedFogMode.Blend:
				Shader.EnableKeyword("_FOG_BLEND");
				Shader.DisableKeyword("_FOG_ADDITIVE");
				Shader.DisableKeyword("_FOG_MULTIPLY");
				Shader.DisableKeyword("_FOG_SCREEN");
				Shader.DisableKeyword("_FOG_OVERLAY");
				Shader.DisableKeyword("_FOG_DODGE");
				break;
			case StylizedFogMode.Additive:
				Shader.DisableKeyword("_FOG_BLEND");
				Shader.EnableKeyword("_FOG_ADDITIVE");
				Shader.DisableKeyword("_FOG_MULTIPLY");
				Shader.DisableKeyword("_FOG_SCREEN");
				Shader.DisableKeyword("_FOG_OVERLAY");
				Shader.DisableKeyword("_FOG_DODGE");
				break;
			case StylizedFogMode.Multiply:
				Shader.DisableKeyword("_FOG_BLEND");
				Shader.DisableKeyword("_FOG_ADDITIVE");
				Shader.EnableKeyword("_FOG_MULTIPLY");
				Shader.DisableKeyword("_FOG_SCREEN");
				Shader.DisableKeyword("_FOG_OVERLAY");
				Shader.DisableKeyword("_FOG_DODGE");
				break;
			case StylizedFogMode.Screen:
				Shader.DisableKeyword("_FOG_BLEND");
				Shader.DisableKeyword("_FOG_ADDITIVE");
				Shader.DisableKeyword("_FOG_MULTIPLY");
				Shader.EnableKeyword("_FOG_SCREEN");
				Shader.DisableKeyword("_FOG_OVERLAY");
				Shader.DisableKeyword("_FOG_DODGE");
				break;
			case StylizedFogMode.Overlay:
				Shader.DisableKeyword("_FOG_BLEND");
				Shader.DisableKeyword("_FOG_ADDITIVE");
				Shader.DisableKeyword("_FOG_MULTIPLY");
				Shader.DisableKeyword("_FOG_SCREEN");
				Shader.EnableKeyword("_FOG_OVERLAY");
				Shader.DisableKeyword("_FOG_DODGE");
				break;
			case StylizedFogMode.Dodge:
				Shader.DisableKeyword("_FOG_BLEND");
				Shader.DisableKeyword("_FOG_ADDITIVE");
				Shader.DisableKeyword("_FOG_MULTIPLY");
				Shader.DisableKeyword("_FOG_SCREEN");
				Shader.DisableKeyword("_FOG_OVERLAY");
				Shader.EnableKeyword("_FOG_DODGE");
				break;
		}

		//Blend
		if(useBlend)
		{
			Shader.EnableKeyword("_FOG_BLEND_ON");
		}else{
			Shader.DisableKeyword("_FOG_BLEND_ON");
		}

		//Noise
		if(useNoise)
		{
			Shader.EnableKeyword("_FOG_NOISE_ON");
		}else{
			Shader.DisableKeyword("_FOG_NOISE_ON");
		}

		if (AdvancedMode) {
			Shader.EnableKeyword ("_ADVANCED_ON");
		}else 
		{
			Shader.DisableKeyword("_ADVANCED_ON");
		}

		if(ExcludeSkybox){
			Shader.EnableKeyword("_SKYBOX");
		}else{
			Shader.DisableKeyword("_SKYBOX");
		}
	}

	private void disableKeywords()
	{
		Shader.DisableKeyword("_FOG_BLEND");
		Shader.DisableKeyword("_FOG_ADDITIVE");
		Shader.DisableKeyword("_FOG_MULTIPLY");
		Shader.DisableKeyword("_FOG_SCREEN");
		Shader.DisableKeyword("_FOG_BLEND_OFF");
		Shader.DisableKeyword("_FOG_BLEND_ON");
		Shader.DisableKeyword("_FOG_NOISE_OFF");
		Shader.DisableKeyword("_FOG_NOISE_ON");
	}

	private bool isSupported()
	{
		if (!SystemInfo.supportsImageEffects)
		{
			return false;
		}

		if(!fogShader.isSupported || fogShader == null){
			return false;
		}
		return true;
	}

	[ImageEffectOpaque]
	void OnRenderImage(RenderTexture source,RenderTexture destination)
	{
		if(!isSupported())
		{
			Graphics.Blit(source,destination);
			return;
		}

		updateValues();
		Graphics.Blit(source,destination,fogMat);
	}

}
