<?php
define('BASE', __DIR__);
require BASE . '/vendor/autoload.php';
$app = require_once BASE . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Modules\Music\Models\MusicCategory;
use Modules\Music\Models\MusicTrack;
use Modules\Music\Models\MusicAlbum;
use Modules\Music\Models\MusicPlaylist;
use Illuminate\Support\Str;

$cats = ['Pop','Rock','Hip-Hop','Electronic','Classical','R&B','Bollywood','Sufi'];
$catIds = [];
foreach ($cats as $n) {
    $c = MusicCategory::firstOrCreate(['slug'=>Str::slug($n)],['name'=>$n,'status'=>1,'created_by'=>1]);
    $catIds[$n] = $c->id;
    echo "Cat: $n ({$c->id})\n";
}

$trackData = [
    ['Summer Vibes','DJ Apex','Electronic',214],['Night Drive','The Cruisers','Pop',187],
    ['Mountain Echo','Rock Giants','Rock',253],['City Lights','Urban Soul','R&B',198],
    ['Dawn Raga','Raaga Masters','Classical',320],['Dil Se','Bollywood Stars','Bollywood',244],
    ['Desert Wind','Sufi Soul','Sufi',290],['Neon Streets','DJ Apex','Electronic',203],
    ['Heartbeat','Urban Soul','R&B',176],['Midnight Blues','Rock Giants','Rock',267],
];
$tids = [];
foreach ($trackData as [$title,$artist,$genre,$dur]) {
    $t = MusicTrack::firstOrCreate(['slug'=>Str::slug($title).'-seed'],[
        'title'=>$title,'artist_name'=>$artist,'genre'=>$genre,'duration'=>$dur,
        'category_id'=>$catIds[$genre]??null,'file_format'=>'mp3',
        'file_url'=>'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        'cover_art_url'=>'https://picsum.photos/seed/'.Str::slug($title).'/300/300',
        'status'=>1,'is_featured'=>rand(0,1),'is_trending'=>rand(0,1),
        'allow_download'=>1,'price'=>0,'play_count'=>rand(100,5000),'like_count'=>rand(10,500),
        'created_by'=>1,'user_id'=>1,
    ]);
    $tids[] = $t->id;
    echo "Track: $title ({$t->id})\n";
}

$a1 = MusicAlbum::firstOrCreate(['slug'=>'apex-electronic-vol1'],[
    'title'=>'Apex Electronic Vol. 1','artist_name'=>'DJ Apex','genre'=>'Electronic',
    'release_date'=>'2025-01-15','cover_art_url'=>'https://picsum.photos/seed/alb1/400/400',
    'description'=>'Electronic beats by DJ Apex.','status'=>1,'is_featured'=>1,
    'category_id'=>$catIds['Electronic']??null,'user_id'=>1,'created_by'=>1,
]);
MusicTrack::whereIn('id',array_slice($tids,0,3))->update(['album_id'=>$a1->id]);
echo "Album: {$a1->title} ({$a1->id})\n";

$a2 = MusicAlbum::firstOrCreate(['slug'=>'soul-of-the-city'],[
    'title'=>'Soul of the City','artist_name'=>'Urban Soul','genre'=>'R&B',
    'release_date'=>'2025-03-20','cover_art_url'=>'https://picsum.photos/seed/alb2/400/400',
    'description'=>'Soulful R&B tracks.','status'=>1,'is_featured'=>1,
    'category_id'=>$catIds['R&B']??null,'user_id'=>1,'created_by'=>1,
]);
MusicTrack::whereIn('id',array_slice($tids,3,2))->update(['album_id'=>$a2->id]);
echo "Album: {$a2->title} ({$a2->id})\n";

$pl1 = MusicPlaylist::firstOrCreate(['slug'=>'top-hits-2025'],[
    'name'=>'Top Hits 2025','slug'=>'top-hits-2025',
    'description'=>'The hottest tracks of 2025.',
    'cover_art_url'=>'https://picsum.photos/seed/pl1/400/400',
    'is_public'=>1,'is_featured'=>1,'user_id'=>1,'created_by'=>1,
]);
$s=[]; foreach(array_slice($tids,0,6) as $p=>$id) $s[$id]=['position'=>$p];
$pl1->tracks()->sync($s);
echo "Playlist: {$pl1->name} ({$pl1->id})\n";

$pl2 = MusicPlaylist::firstOrCreate(['slug'=>'chill-vibes'],[
    'name'=>'Chill Vibes','slug'=>'chill-vibes',
    'description'=>'Relax and unwind.',
    'cover_art_url'=>'https://picsum.photos/seed/pl2/400/400',
    'is_public'=>1,'is_featured'=>0,'user_id'=>1,'created_by'=>1,
]);
$s=[]; foreach(array_slice($tids,4,5) as $p=>$id) $s[$id]=['position'=>$p];
$pl2->tracks()->sync($s);
echo "Playlist: {$pl2->name} ({$pl2->id})\n";

echo "\nDone! Delete this file.\n";
