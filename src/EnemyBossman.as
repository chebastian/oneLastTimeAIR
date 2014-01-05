package  
{
	import adobe.utils.CustomActions;
	import CharacterStates.IdleState;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyBossman extends EnemyWalker 
	{
		
		public function EnemyBossman(game:PlayState, pos:Point) 
		{
			super(game, pos);
			mAnimationsPath = "./media/character/bigboss/bigboss_anims.txt";
		}
		
		override public function Init():void 
		{
			super.Init();
			ChangeState(new IdleState(0, this));
		}
		
		override public function InitAnimations():void 
		{
			super.InitAnimations();
			Animation_Attack_D = "charge";
			Animation_Attack_L = "charge";
			Animation_Attack_R = "charge";
			Animation_Attack_U = "charge";
			
			Animation_WalkRight = "walkR";
			Animation_WalkLeft = "walkL";
		}
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			mBulletOriginOffset = new Point(width / 2, height);
			ChangeState(new IdleState(0, this));
		}
		
		override protected function updateLookAt():void 
		{
			mLookAt = mHeading.clone();
		}
		
	}

}