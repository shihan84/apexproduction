<?php

namespace Modules\Music\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Modules\Music\Models\MusicCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class MusicCategoriesController extends Controller
{
    public function index()
    {
        $categories = MusicCategory::latest()->paginate(20);
        return view('music::backend.categories.index', compact('categories'));
    }

    public function create()
    {
        return view('music::backend.categories.create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'        => 'required|string|max:255|unique:music_categories,name',
            'description' => 'nullable|string',
            'status'      => 'boolean',
        ]);

        $validated['slug']   = Str::slug($validated['name']);
        $validated['status'] = $request->boolean('status', true) ? 1 : 0;

        MusicCategory::create($validated);

        return redirect()->route('backend.music.categories.index')
            ->with('success', 'Category created successfully.');
    }

    public function edit(MusicCategory $category)
    {
        return view('music::backend.categories.edit', compact('category'));
    }

    public function update(Request $request, MusicCategory $category)
    {
        $validated = $request->validate([
            'name'        => 'required|string|max:255|unique:music_categories,name,' . $category->id,
            'description' => 'nullable|string',
            'status'      => 'boolean',
        ]);

        $validated['slug']   = Str::slug($validated['name']);
        $validated['status'] = $request->boolean('status', true) ? 1 : 0;

        $category->update($validated);

        return redirect()->route('backend.music.categories.index')
            ->with('success', 'Category updated successfully.');
    }

    public function destroy(MusicCategory $category)
    {
        $category->delete();

        return redirect()->route('backend.music.categories.index')
            ->with('success', 'Category deleted successfully.');
    }
}
