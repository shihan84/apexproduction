<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
return new class extends Migration {
    public function up(): void {
        if(!DB::table('constants')->where('type','notification_type')->where('value','short_add')->exists()) {
            DB::table('constants')->insert(['type'=>'notification_type','value'=>'short_add','name'=>'Short Add','created_at'=>now(),'updated_at'=>now()]);
        }
        if(!DB::table('notification_templates')->where('type','short_add')->exists()) {
            $id=DB::table('notification_templates')->insertGetId(['name'=>'short_add','label'=>'Short Video Added','type'=>'short_add','status'=>1,'to'=>'["user"]','channels'=>'{"IS_MAIL":"0","PUSH_NOTIFICATION":"1","IS_CUSTOM_WEBHOOK":"0"}','created_at'=>now(),'updated_at'=>now()]);
            $rows=[['user','New short video available!','New Short Video!'],['admin','Short video added.','Short Video Added!'],['demo_admin','Short video added.','Short Video Added!']];
            foreach($rows as $r){DB::table('notification_template_content_mapping')->insert(['template_id'=>$id,'language'=>'en','notification_link'=>'','notification_message'=>$r[1],'status'=>1,'user_type'=>$r[0],'subject'=>$r[2],'notification_subject'=>$r[2],'notification_template_detail'=>$r[1],'template_detail'=>'<p>Dear [[ user_name ]],</p><p>'.$r[1].'</p>','created_at'=>now(),'updated_at'=>now()]);}
        }
    }
    public function down(): void {
        $id=DB::table('notification_templates')->where('type','short_add')->value('id');
        if($id){DB::table('notification_template_content_mapping')->where('template_id',$id)->delete();DB::table('notification_templates')->where('id',$id)->delete();}
        DB::table('constants')->where('type','notification_type')->where('value','short_add')->delete();
    }
};
