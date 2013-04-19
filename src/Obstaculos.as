package  
{
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author Sephi_MBC
	 */
	public class Obstaculos extends MovieClip
	{
		
		public var obstaculos:Array;
		var main:Main;
		var libro1:Libro1_ = new Libro1_();
		var libro2:Libro2_ = new Libro2_();
		var libro3:Libro3_ = new Libro3_();
		var libro4:Libro4_ = new Libro4_();
		var señora:Señora = new Señora();
		var campesino:Campesino = new Campesino();
		var libro0:Biblia_Caminando_ = new Biblia_Caminando_();
		//var librop:Libro1 = new Libro1();
		
		var timer:Timer;
		var numObstaculo:Number;
		
		public var objetoTocado:Array;
		
		public function Obstaculos(main:Main) 
		{
			timer = new Timer(randomNumber(1, 3) * 900, 0);
			obstaculos = new Array(libro0,libro1,libro2,libro3,libro4,señora,campesino);
			this.main = main;
			iniciar();
		}
		
		function iniciar():void {
			timer.addEventListener(TimerEvent.TIMER, saleObstaculo);
			numObstaculo = randomNumber(0, obstaculos.length-1);
			organizarObstaculos(obstaculos);
			main.addEventListener(Event.ENTER_FRAME, nuevoFrame);
			//librop.x = 500;
			//librop.y = main.carreteraMedia;
			//main.addChild(librop);
			timer.start();
		}
		
		function terminar():void {
			timer.removeEventListener(TimerEvent.TIMER, saleObstaculo);
			timer.stop();
			main.removeEventListener(Event.ENTER_FRAME, nuevoFrame);
			for (var n:Number; n < obstaculos.length; n++) {
				obstaculos[n].visible = false;
				objetoTocado[n] = false;
				main.removeChild(obstaculos[n]);
			}
		}
		
		function organizarObstaculos(arreglo:Array):void {
			objetoTocado = new Array();
			for (var n:Number = 0; n < arreglo.length; n++) {
				arreglo[n].x = 500;
				arreglo[n].visible = false;
				objetoTocado.push(false);
				main.addChild(arreglo[n]);
			}
		}
		
		function nuevoFrame(event:Event):void {
			for (var n:Number = 0; n < obstaculos.length; n++) {
				if (obstaculos[n].currentFrame == 15 && obstaculos[n].visible==true) {
					obstaculos[n].visible = false;
					//obstaculos[numObstaculo].stop();
					//main.removeChild(obstaculos[n]);
					//trace("ok"+n);
				}				
			}
		}
		
		function saleObstaculo(event:Event):void {
			//var d:MovieClip;
			//d.rem
			do {
				numObstaculo = randomNumber(0, obstaculos.length - 1);		
			}while (obstaculos[numObstaculo].visible == true);
			switch(randomNumber(1, 3)) {
				case 1:
					obstaculos[numObstaculo].y = main.carreteraAbajo;
					main.setChildIndex(obstaculos[numObstaculo], 6);
					break;
				case 2:
					obstaculos[numObstaculo].y = main.carreteraMedia;
					main.setChildIndex(obstaculos[numObstaculo], 4);
					break;
				case 3:
					obstaculos[numObstaculo].y = main.carreteraAlta;
					main.setChildIndex(obstaculos[numObstaculo], 2);
					break;
			}
			if (obstaculos[numObstaculo].visible == false) {
				obstaculos[numObstaculo].visible = true;
				obstaculos[numObstaculo].play();
			}
			//trace("  ");
			
		}
		
		function randomNumber(low:Number , high:Number ):Number {
			return Math.floor(Math.random() * (1+high-low)) + low;
		}

	}

} 