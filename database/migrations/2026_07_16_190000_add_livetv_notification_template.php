<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        if (!DB::table('constants')->where('type', 'notification_type')->where('value', 'livetv_add')->exists()) {
            DB::table('constants')->insert(['type' => 'notification_type', 'value' => 'livetv_add', 'name' => 'Live TV Add', 'created_at' => now(), 'updated_at' => now()]);
        }

        if (!DB::table('notification_templates')->where('type', 'livetv_add')->exists()) {
            $id = DB::table('notification_templates')->insertGetId(['name' => 'livetv_add', 'label' => 'Live TV Channel Added', 'type' => 'livetv_add', 'status' => 1, 'to' => '["user"]', 'channels' => '{"IS_MAIL":"0","PUSH_NOTIFICATION":"1","IS_CUSTOM_WEBHOOK":"0"}', 'created_at' => now(), 'updated_at' => now()]);

            foreach ([['user', 'New Live TV channel "[[ name ]]" is now available!'], ['admin', 'Live TV channel "[[ name ]]" added.'], ['demo_admin', 'Live TV channel "[[ name ]]" added.']] as $utm) {
                DB::table('notification_template_content_mapping')->insert(['template_id' => $id, 'language' => 'en', 'notification_link' => '', 'notification_message' => $utm[1], 'status' => 1, 'user_type' => $utm[0], 'subject' => 'Live TV Channel Added!', 'notification_subject' => 'Content Added', 'notification_template_detail' => $utm[1], 'template_detail' => '<p>Dear [[ user_name ]],</p><p>Live TV channel "<strong>[[ name ]]</strong>" added.</p>', 'created_at' => now(), 'updated_at' => now()]);
            }
        }
    }

    public function down(): void
    {
        $tpl = DB::table('notification_templates')->where('type', 'livetv_add')->first();
        if ($tpl) {
            DB::table('notification_template_content_mapping')->where('template_id', $tpl->id)->delete();
            DB::table('notification_templates')->where('id', $tpl->id)->delete();
        }
        DB::table('constants')->where('type', 'notification_type')->where('value', 'livetv_add')->delete();
    }
};
