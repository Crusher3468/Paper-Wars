using Godot;
using System;

public partial class BitBoard : Node
{
	// Called when the node enters the scene tree for the first time.
	public ulong[] pieces = { 0, 0, 0 };
	public override void _Ready()
	{

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void TestFunc() 
	{
		GD.Print("I am the C#");
	}
}
