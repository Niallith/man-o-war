package com.flashsockets.manowar.util
{
	import com.vizsage.as3mathlib.math.alg.Point;
	import com.vizsage.as3mathlib.math.geom.curve.BezQuad;
	
	import flash.geom.Point;
	
	public class Calcul
	{
		public static function getLongueurCourbeBezier(startX:Number,startY:Number,anchorX:Number,anchorY:Number
													   ,destinationX:Number,destinationY:Number):Number
		{
			var bez:BezQuad = new BezQuad();
			var bezLength:Number = bez.arcLength(new com.vizsage.as3mathlib.math.alg.Point(startX,startY),new com.vizsage.as3mathlib.math.alg.Point(anchorX,anchorY),new com.vizsage.as3mathlib.math.alg.Point(destinationX,destinationY));
			return bezLength;
		}
		
		public static function calculateFuturPosition(bateauPoint:flash.geom.Point, anchorPoint:flash.geom.Point,
													  destinationPoint:flash.geom.Point, dateStartMovement:Date, 
													  dureeMovement:Number, equipageSpeed:Number):flash.geom.Point
		{
			var futurPosition:flash.geom.Point;
			var currentT:Number = (new Date().getTime() - dateStartMovement.getTime())/dureeMovement;
			var currenTFormula:Number = currentT/dureeMovement;
			if(currentT+currenTFormula > 1)
				return destinationPoint
			else{
				futurPosition.x = Math.pow((1-currenTFormula),2)*bateauPoint.x+2*currenTFormula*(1-currenTFormula)*anchorPoint.x+Math.pow(currenTFormula,2)*destinationPoint.x;
				futurPosition.y = Math.pow((1-currenTFormula),2)*bateauPoint.y+2*currenTFormula*(1-currenTFormula)*anchorPoint.y+Math.pow(currenTFormula,2)*destinationPoint.y;
			
				return futurPosition;
			}
		}
		
		public static function isTheShipMovementGood(finalPosition:flash.geom.Point):Boolean
		{
			
			return true;
		}
	}
}