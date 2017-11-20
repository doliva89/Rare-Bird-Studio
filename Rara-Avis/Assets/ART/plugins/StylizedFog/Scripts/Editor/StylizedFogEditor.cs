using UnityEngine;
using System.Collections;
using UnityEditor;
using System.Collections.Generic;

[CustomEditor(typeof(StylizedFog))]
public class StylizedFogEditor : Editor {

	SerializedObject fog;
	
	void OnEnable () 
	{
		fog = new SerializedObject (target);
		fog.ApplyModifiedProperties();
	}


	public override void OnInspectorGUI()
	{
	
		fog.Update();
		
		List<string> excludedProperties = new List<string>();

		SerializedProperty _gradient	= fog.FindProperty("gradientSource");
		SerializedProperty _useBlend 	= fog.FindProperty("useBlend");
		SerializedProperty _useNoise	= fog.FindProperty("useNoise");
		SerializedProperty _advancedMode = fog.FindProperty ("AdvancedMode");

		//Texture Mode
		if(_gradient.enumValueIndex == 0)
		{
			excludedProperties.Add("rampGradient");
			excludedProperties.Add("rampBlendGradient");
		}
		//Gradient Mode
		if(_gradient.enumValueIndex == 1)
		{
			excludedProperties.Add("rampTexture");
			excludedProperties.Add("rampBlendTexture");
		}
		//Blend
		if(_useBlend.boolValue == false)
		{
			excludedProperties.Add("rampBlendTexture");
			excludedProperties.Add("rampBlendGradient");
			excludedProperties.Add("blend");
		}
		//Noise Texture
		if(_useNoise.boolValue == false)
		{
			excludedProperties.Add("noiseTexture");
		}
		excludedProperties.Add("noiseSpeed");
		excludedProperties.Add("noiseTiling");

		//AdvancedMode
		if (_advancedMode.boolValue == false) 
		{
			excludedProperties.Add("NearRange");
			excludedProperties.Add("FarRange");
		}



		Texture2D tex = Resources.Load("StylizedFogLogo") as Texture2D;
		
		GUILayout.BeginHorizontal();
		GUILayout.FlexibleSpace();
		GUILayout.Label(tex);	
		GUILayout.FlexibleSpace();
		GUILayout.EndHorizontal();
		
		EditorGUI.BeginChangeCheck ();

		DrawPropertiesExcluding(fog,excludedProperties.ToArray());

		if(_useNoise.boolValue)
		{
			StylizedFog fogTarget = (StylizedFog)target;

			//Noise 1 Speed
			EditorGUILayout.LabelField("Noise Speed",EditorStyles.boldLabel);
			EditorGUILayout.BeginHorizontal();

				EditorGUILayout.LabelField("X",GUILayout.Width(20f));
				fogTarget.noiseSpeed.x = EditorGUILayout.FloatField(fogTarget.noiseSpeed.x);
		
				EditorGUILayout.LabelField("Y",GUILayout.Width(20f));
				fogTarget.noiseSpeed.y = EditorGUILayout.FloatField(fogTarget.noiseSpeed.y);
			
			EditorGUILayout.EndHorizontal();

			//Noise 2 Speed
			EditorGUILayout.BeginHorizontal();

				EditorGUILayout.LabelField("X",GUILayout.Width(20f));
				fogTarget.noiseSpeed.z = EditorGUILayout.FloatField(fogTarget.noiseSpeed.z);

				EditorGUILayout.LabelField("Y",GUILayout.Width(20f));
				fogTarget.noiseSpeed.w = EditorGUILayout.FloatField(fogTarget.noiseSpeed.w);

			EditorGUILayout.EndHorizontal();

			//Noise Tiling
			EditorGUILayout.LabelField("Noise Tiling",EditorStyles.boldLabel);
			EditorGUILayout.BeginHorizontal();
				
				EditorGUILayout.LabelField("X",GUILayout.Width(20f));
				fogTarget.noiseTiling.x = EditorGUILayout.FloatField(fogTarget.noiseTiling.x);
				
				EditorGUILayout.LabelField("Y",GUILayout.Width(20f));
				fogTarget.noiseTiling.y = EditorGUILayout.FloatField(fogTarget.noiseTiling.y);
			
			EditorGUILayout.EndHorizontal();
			
			//Noise 2 Tiling
			EditorGUILayout.BeginHorizontal();
			
				EditorGUILayout.LabelField("X",GUILayout.Width(20f));
				fogTarget.noiseTiling.z = EditorGUILayout.FloatField(fogTarget.noiseTiling.z);
				
				EditorGUILayout.LabelField("Y",GUILayout.Width(20f));
				fogTarget.noiseTiling.w = EditorGUILayout.FloatField(fogTarget.noiseTiling.w);
			
			EditorGUILayout.EndHorizontal();
		}


		if (EditorGUI.EndChangeCheck()) 
		{

			fog.ApplyModifiedProperties();
			(fog.targetObject as StylizedFog).gameObject.SendMessage ("UpdateTextures");
			//EditorUtility.SetDirty(fogTarget);


		}

	}

}
