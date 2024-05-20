using Godot;
using System;
using System.Collections.Generic;

public partial class DataHandler : Node
{
    // Called when the node enters the scene tree for the first time.
    enum PieceNames { TANK, PLANE, BOAT }
	public static Dictionary<char, int> Dic = new Dictionary<char, int>()
	{
		{ 't', 0 }, { 'p', 1 }, { 'b',  2 }
	};
    public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
